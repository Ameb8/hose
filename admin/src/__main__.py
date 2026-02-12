import tkinter as tk
from tkinter import ttk
from dotenv import load_dotenv

import requests
import threading
import os
import sys

from typing import Type

DEBUG: bool = False # Default to off

# Check args for debug mode
if "-d" in sys.argv or "--debug" in sys.argv:
    DEBUG = True


# Debug mode enabled
if DEBUG:
    print("Debug mode is ON")

# Load .env file
load_dotenv()  # Loads variables from .env

# Set API credentials and domain
API_KEY: str = os.getenv("ADMIN_KEY")
API_URL: str = "http://localhost:8080"


class App(tk.Tk):
    def __init__(self) -> None:
        super().__init__()

        self.title("HOSE Property Manager")
        self.geometry("400x200")

        container: ttk.Frame = ttk.Frame(self)
        container.pack(fill="both", expand=True)

        container.grid_rowconfigure(0, weight=1)
        container.grid_columnconfigure(0, weight=1)

        self.frames = {}

        for Page in (HomePage, CreatePropertyPage, ImageManagerPage):
            frame: ttk.Frame = Page(container, self)
            self.frames[Page] = frame
            frame.grid(row=0, column=0, sticky="nsew")

        self.show_frame(HomePage)

    def show_frame(self, page: Type[ttk.Frame]) -> None:
        frame: ttk.Frame = self.frames[page]
        frame.tkraise()


class HomePage(ttk.Frame):
    def __init__(self, parent: tk.Widget, controller: App) -> None:
        super().__init__(parent)

        ttk.Label(self, text="HOSE Property Manager (Admin Only)").pack(pady=10)

        ttk.Button(
            self,
            text="Add New Property",
            command=lambda: controller.show_frame(CreatePropertyPage)
        ).pack(pady=5)

        ttk.Button(
            self,
            text="Manage Property Images",
            command=lambda: controller.show_frame(ImageManagerPage)
        ).pack(pady=5)

        ttk.Button(
            self,
            text="Exit",
            command=controller.destroy
        ).pack(pady=10)

class ScrollableFrame(ttk.Frame):
    def __init__(self, parent):
        super().__init__(parent)

        self.canvas = tk.Canvas(self, highlightthickness=0)
        scrollbar = ttk.Scrollbar(self, orient="vertical", command=self.canvas.yview)

        self.inner = ttk.Frame(self.canvas)

        self.inner_id = self.canvas.create_window(
            (0, 0), window=self.inner, anchor="nw"
        )

        self.canvas.configure(yscrollcommand=scrollbar.set)

        self.canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        # Update scroll region
        self.inner.bind(
            "<Configure>",
            lambda e: self.canvas.configure(scrollregion=self.canvas.bbox("all"))
        )

        # Make inner frame follow canvas width
        self.canvas.bind(
            "<Configure>",
            lambda e: self.canvas.itemconfig(self.inner_id, width=e.width)
        )

        # Mouse wheel scrolling
        self.canvas.bind_all(
            "<MouseWheel>",
            lambda e: self.canvas.yview_scroll(int(-1 * (e.delta / 120)), "units")
        )




class CreatePropertyPage(ttk.Frame):
    fields: dict[str, tk.StringVar]
    status: ttk.Label

    def __init__(self, parent: tk.Widget, controller: App) -> None:
        super().__init__(parent)

        scroll = ScrollableFrame(self)
        scroll.pack(fill="both", expand=True)

        content = scroll.inner

        ttk.Label(content, text="Create Property", font=("Arial", 14)).pack(pady=10)

        form: ttk.Frame = ttk.Frame(content)
        form.pack(fill="x", padx=20)

        # Field definitions
        self.fields = {
            "name": tk.StringVar(),
            "propertyType": tk.StringVar(),
            "description": tk.StringVar(),
            "contactPhone": tk.StringVar(),
            "contactEmail": tk.StringVar(),
            "latitude": tk.StringVar(),
            "longitude": tk.StringVar(),
            "street": tk.StringVar(),
            "city": tk.StringVar(value='Ellensburg'),
            "state": tk.StringVar(value='WA'),
            "zip": tk.StringVar(value='98926'),
        }

        # --- Unit Types Section ---
        ttk.Label(content, text="Unit Types", font=("Arial", 12)).pack(pady=(15, 5))

        self.unit_container = ttk.Frame(content)
        self.unit_container.pack(fill="both", padx=20)

        self.unit_forms: list[UnitTypeForm] = []

        ttk.Button(
            content,
            text="+ Add Unit Type",
            command=self.add_unit_type
        ).pack(pady=5)

        # Property Type dropdown
        ttk.Label(form, text="Property Type").grid(row=0, column=0, sticky="w", pady=2)
        self.property_type_combobox = ttk.Combobox(form, textvariable=self.fields["propertyType"], 
                                                   values=["dorm", "apartment", "house"], state="readonly")
        self.property_type_combobox.grid(row=0, column=1, sticky="ew", pady=2)

        # Collect text field inputs
        for i, (label, var) in enumerate(self.fields.items()):
            if label != "propertyType":  # Skip the propertyType field text parsing
                ttk.Label(form, text=label).grid(row=i + 1, column=0, sticky="w", pady=2)
                ttk.Entry(form, textvariable=var).grid(row=i + 1, column=1, sticky="ew", pady=2)

        form.columnconfigure(1, weight=1)

        self.status = ttk.Label(content, text="")
        self.status.pack(pady=5)

        ttk.Button(content, text="Submit", command=self.submit).pack(pady=5)
        ttk.Button(
            content,
            text="Back",
            command=lambda: controller.show_frame(HomePage)
        ).pack(pady=5)

    def add_unit_type(self) -> None:
        form = UnitTypeForm(self.unit_container)
        form.pack(fill="x", pady=5)
        self.unit_forms.append(form)


    def submit(self) -> None:
        self.status.config(text="Submitting...")

        # Collect form data into dictionary
        data: Dict[str, Any] = {k: v.get() for k, v in self.fields.items()}

        # Convert propertyType to uppercase to match server ENUM
        data["propertyType"] = data["propertyType"].upper()

        try: # Convert lat/long to floats 
            if data["latitude"]:
                data["latitude"] = float(data["latitude"])
            if data["longitude"]:
                data["longitude"] = float(data["longitude"])

            # Collect unit types
            data["unitTypes"] = [
                form.get_data()
                for form in self.unit_forms
            ]
        except ValueError as e:
            self.status.config(text=str(e))
            return

        threading.Thread(
            target=self.make_request,
            args=(data,),
            daemon=True
        ).start()


    def make_request(self, data: dict[str, any]) -> None:
        headers = {
            "X-API-Key": API_KEY
        }

        if DEBUG: # Display request header/body
            print(f'\n\nHeaders:\n\n{headers}')
            print(f'\n\nPayload for POST request:\n\n{data}')


        try: # Attempt to make POST request
            response: requests.Response = requests.post(
                f'{API_URL}/properties',
                json=data,
                headers=headers,
                timeout=5
            )

            if DEBUG: # Display server response
                print(f'\n\nResponse Status Code: {response.status_code}')
                print(f'\nResponse Content:\n\n{response.json()}')

            response.raise_for_status()

            self.after(0, lambda: self.status.config(
                text=f"Success: {response.json()}"
            ))

        except requests.RequestException as e:
            self.after(0, lambda e=e: self.status.config(
                text=f"Error: {e}"
            ))


class ImageManagerPage(ttk.Frame):
    def __init__(self, parent: tk.Widget, controller: App) -> None:
        super().__init__(parent)

        ttk.Label(self, text="Image Manager").pack(pady=10)
        ttk.Label(self, text="We're working on it .....").pack(pady=5)

        ttk.Button(
            self,
            text="Back",
            command=lambda: controller.show_frame(HomePage)
        ).pack(pady=10)


class UnitTypeForm(ttk.Frame):
    def __init__(self, parent):
        super().__init__(parent, relief="ridge", padding=8)

        self.vars = {
            "name": tk.StringVar(),
            "bedrooms": tk.StringVar(),
            "bathrooms": tk.StringVar(),
            "rentCents": tk.StringVar(),
            "availabilityDate": tk.StringVar(),
            "totalUnits": tk.StringVar(),
            "availableUnits": tk.StringVar(),
            "description": tk.StringVar(),
        }

        for i, (label, var) in enumerate(self.vars.items()):
            ttk.Label(self, text=label).grid(row=i, column=0, sticky="w", pady=2)
            ttk.Entry(self, textvariable=var).grid(row=i, column=1, sticky="ew", pady=2)

        self.columnconfigure(1, weight=1)

    def get_data(self) -> dict:
        """Convert fields into correct JSON-ready types"""
        try:
            return {
                "name": self.vars["name"].get(),
                "bedrooms": int(self.vars["bedrooms"].get()),
                "bathrooms": int(self.vars["bathrooms"].get()),
                "rentCents": int(self.vars["rentCents"].get()),
                "availabilityDate": self.vars["availabilityDate"].get(),
                "totalUnits": int(self.vars["totalUnits"].get()),
                "availableUnits": int(self.vars["availableUnits"].get()),
                "description": self.vars["description"].get(),
            }
        except ValueError:
            raise ValueError("Invalid numeric value in unit type")



if __name__ == "__main__":
    app: App = App()
    app.mainloop()
