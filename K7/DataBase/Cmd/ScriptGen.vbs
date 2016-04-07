option explicit
 
const Class_ScriptGenerator = "{CCFA446A-DF08-4632-AB3E-ED48A95BC5FF}"

Dim a
Set a = CreateObject("IntecDB.Application")

a.Title = "Show Structure"

a.Connect "Provider=MSDAORA;Data Source=ALTER_SRV;User ID=crr2;Password=crr2"

a.SchemaName = "SDV_PU"

a.AddMenuItem "Script Generator", Class_ScriptGenerator


a.RunObject Class_ScriptGenerator
'a.Run
