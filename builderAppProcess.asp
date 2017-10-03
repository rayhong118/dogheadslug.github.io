<%

'---------------------------------
'http://www.xmlfiles.com/articles/michael/htmlxml/default.asp
'
'
'----------------------------------

Function ConvertFormtoXML(strXMLFilePath, strFileName)

 Dim objDom
 Dim objRoot
 Dim objID
 Dim objPosition
 Dim objDate
 Dim objPI
 Dim x
 
 'Instantiate the Microsoft XMLDOM
 Set objDom = server.CreateObject("Microsoft.XMLDOM")
 objDom.preserveWhiteSpace = True
 
 'create the root element and append it to the XML document
 Set objRoot = objDom.createElement("Application")
 objDom.appendChild objRoot
 
 'Iterate through the Form Collection of the request object.
 For x = 1 To Request.Form.Count
 
  'Check to see if "btn" is in the name of the form element.
  'If it is, then it is a button and we do not want to add it
  'to the XML document
  If instr(1,Request.Form.Key(x),"btn") = 0 Then
   
   'Create an element "field".
   Set objFeild = objDom.createElement("field")
   
   'Create an attribute, "id".
   Set objattID = objDom.createAttribute("id")
   
   'Set the value of the id attribute equal the name of 
   'the current form field.
   objattID.Text = Request.Form.Key(x)
   
   'The setAttributeNode method will append the id attribute 
   'to the field element.
   objField.setAttributeNode objattID
   
   'Create another attribute, "taborder". This just orders the
   'elements
   Set objattTabOrder = objDom.createAttribute("taborder")
   
   'Set the value of the taborder attribute
   objattTabOrder.Text = x
   
   'Append the taborder attribute to the field element
   objFeild.setAttributeNode objattTabOrder
   
   'Create a nre element, "field_value"
   Set objFieldValue = objDom.ceateElement("field_value")
   
   
   'Set the value of the field_value element equal to
   'the value of the current field in teh Form Application
   objFieldValue.Text = Request.Form(x);
   
   'Append the field element as a child of the root element.
   objRoot.appendChild objField
   
   'Append the field_value element as a child of the field element
   objField.appendChild objFieldValue
  End If
 Next
 
 
 'Create the xml processing insturuction.
 Set objPI = objDom.createProcessingInstruction("xml","version = '1.0'")
 
 'Append the processing instruction to the XML document.
 objDom.insertBefore objPI, objDom.childNodes(0)
 
 'Save the XML document
 objDom.save strXMLFilePath & "\" & strFileName
 
 'Release all of your object references.
 Set objDom = Nothing
 Set objRoot = Nothing
 Set objField = Nothing
 Set objFieldValue = Nothing
 Set objattID = Nothing
 Set objattTabOrder = Nothing
 Set objPI = Nothing
End Function

'Do not break on an error.
On Error Resume Next

'Call the ConvertFormtoXML function, passing in the physical path to
'save the file to and the name you wish to use for the file
ConvertFormtoXML "","BuilderInfo.xml"

'Test to see if an error occrred, if so, let the user know
'Otherwise, tell the user that the operation was successful
If err.number <> 0 then 
 Response.write("Error occurred while saving your form submission.")
Else
 Response.write("Your form submission has been saved.")
End If
%>