Set args = WScript.Arguments
emailSubjText = args.Item(0)
emailBodyText = args.Item(1)

Set objMail = CreateObject("CDO.Message")
Set objConf = CreateObject("CDO.Configuration")
Set objFlds = objConf.Fields

objFlds.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = False
objFlds.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 0
objFlds.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.bost.com"
objFlds.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
objFlds.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
objFlds.Update

objMail.Configuration = objConf

objMail.From = "titan@bost.com"
objMail.To = "taha.saghir@streebo.com"
objMail.Subject = emailSubjText
objMail.TextBody = emailBodyText
objMail.Send
Set objFlds = Nothing
Set objConf = Nothing
Set objMail = Nothing