import PySimpleGUI as sg


# Homepage 
home = [
    [sg.Text('HOSE Property Manager (Admin Only)')],
    [sg.Button('Add New Property'), sg.Button('Manage Property Images')],
    [sg.Button("Exit")]
]

create_property = [
    [sg.Text('Create Property')],
    
]

image_manager = [
    [sg.Text('Image Manager')],
    [sg.Text('We\'re working on it .....')]
]



# Function to create the window
def create_window(layout):
    return sg.Window("HOSE Property Manager", layout, finalize=True)


# Create the window
window = create_window(home)


# Event loop
while True:
    # Collect user input
    event, values = window.read()

    # Exit application
    if event == sg.WIN_CLOSED or event == "Exit":
        break
    
    # Navigate to new property page
    if event == "Add New Property":
        window.close()
        window = create_window(create_property)
    
    # Navigate to image manager
    if event == "Manage Property Images":
        window.close()
        window = create_window(image_manager)


window.close()