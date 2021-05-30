# +
*** Settings ***
Documentation     Orders robots from RobotSpareBin Industries Inc.
...               Saves the order HTML receipt as a PDF file.
...               Saves the screenshot of the ordered robot.
...               Embeds the screenshot of the robot to the PDF receipt.
...               Creates ZIP archive of the receipts and the images.

Library           Collections
Library           MyLibrary
Resource          keywords.robot
Variables         MyVariables.py
Library           RPA.Browser
Library           RPA.Robocloud.Secrets
Library           RPA.Dialogs
Library           RPA.HTTP
Library           RPA.Tables
Library           RPA.Desktop
Library           RPA.PDF
Library           RPA.Archive
# -


*** Tasks ***
Order robots from RobotSpareBin Industries Inc
    Log     Orders processing has been started!
    Open the robot order website
    ${orders}=    Get orders
    FOR    ${row}    IN    @{orders}
        Close the annoying modal
        Fill the form    ${row}
        Preview the robot
        Submit the order
        ${pdf}=    Store the receipt as a PDF file    ${row}[Order number]
        ${screenshot}=    Take a screenshot of the robot    ${row}[Order number]
        Embed the robot screenshot to the receipt PDF file    ${screenshot}    ${pdf}
        Go to order another robot
    END
    Create a ZIP file of the receipts
    Close the robot order website
    Log     Orders processing has been completed Successfully!


