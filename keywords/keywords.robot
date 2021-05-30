*** Settings ***
Documentation     Keyword store to include in tasks



# +
*** Keywords ***
Open the robot order website
    Log    Opening the robot order website
    ${config}=    Get Secret    botConfig
    Log     ${config}[url]
    Open Available Browser  ${config}[url]
    Maximize Browser Window
    
Close the robot order website
    Close Browser
    
Close the annoying modal
    Click Element When Visible      xpath://button[@class='btn btn-dark']

Get orders
    Create Form     title=User COnfirmation Form
    Add Text Input  label=URL for orders file      name=csv_url   value=Place the csv url here
    ${response}=    Request Response
    Log             ${response}
    ${csv_url}=      Set Variable    ${response["csv_url"]}
    Log             ${csv_url}
    
    Download     ${csv_url}    overwrite=True
    ${table}=    Read Table From Csv    orders.csv
    [Return]     ${table}
    

Fill the form
    [Arguments]    ${order}
    # Choose head
    Select From List By Value     xpath://select[@id='head']       ${order}[Head]
    # Choose body
    Click Element When Visible    xpath://label[@for='id-body-${order}[Body]']
    # Choose legs
    Sleep           2s
    RPA.Desktop.Press Keys    tab
    Type Text    ${order}[Legs]
    # Enter address
    Input Text                    xpath://input[@placeholder='Shipping address']    ${order}[Address]

Preview the robot
     Click Button When Visible    xpath://button[@id='preview']

Submit the order
     Click Button When Visible    xpath://button[normalize-space()='Order']
     ${elementExists}=            Is Element Visible      xpath://button[normalize-space()='Order']
     IF     ${elementExists} == True
         Sleep      5s
         Click Element If Visible     xpath://button[normalize-space()='Order']
     END
     
     ${elementExists1}=            Is Element Visible      xpath://h3[normalize-space()='Receipt']

     FOR    ${i}    IN RANGE    4
        
        Click Element If Visible     xpath://button[normalize-space()='Order']
        Sleep   5s
        ${elementExists1}=            Is Element Visible      xpath://h3[normalize-space()='Receipt']
        Exit For Loop If    ${elementExists1} == True
     END
     Mute Run On Failure    Wait Until Element Is Visible
     Wait Until Element Is Visible  xpath://h3[normalize-space()='Receipt']

Store the receipt as a PDF file
    [Arguments]    ${order_number}
    ${receipt_element}=    Get Element Attribute    xpath://div[@id='receipt']    outerHTML
    Html To Pdf    ${receipt_element}    ${OUTPUT_DIR}${/}receipts${/}Order_${order_number}.pdf
    [Return]    ${OUTPUT_DIR}${/}receipts${/}Order_${order_number}.pdf

Take a screenshot of the robot
    [Arguments]    ${order_number}
    Capture Element Screenshot    xpath://div[@id='robot-preview-image']  ${OUTPUT_DIR}${/}temp${/}Image_${order_number}.png
    [Return]    ${OUTPUT_DIR}${/}temp${/}Image_${order_number}.png

Embed the robot screenshot to the receipt PDF file
    [Arguments]    ${screenshot}    ${pdf}
    Open Pdf     ${pdf}
    Add Watermark Image To Pdf    ${screenshot}    ${pdf}
    Close Pdf    ${pdf}

Go to order another robot
    Click Button When Visible   xpath://button[normalize-space()='Order another robot']

Create a ZIP file of the receipts
    Archive Folder With Zip    ${OUTPUT_DIR}${/}receipts    ${OUTPUT_DIR}${/}Archived_Receipts.zip


# -


