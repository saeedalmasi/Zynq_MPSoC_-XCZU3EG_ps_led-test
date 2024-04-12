set tclPath [pwd]
cd $tclPath
cd ..
set projpath [pwd]
puts "Current workspace is $projpath"
setws $projpath
getws
set xsaName design_1_wrapper
set app0Name xgpiops_polled_example
set app1Name ps_key
set app2Name ps_led

#Create a new platform
platform create -name $xsaName -hw $projpath/$xsaName.xsa -proc psu_cortexa53_0 -os standalone -arch 64-bit -out $projpath
importprojects $projpath/$xsaName
platform active $xsaName
repo -add-platforms $xsaName
importsources -name $xsaName/zynqmp_fsbl -path $tclPath/src/fsbl -target-path ./

domain active
#Create a new application
app create -name $app0Name -platform $xsaName -domain standalone_domain -template "Empty Application"
importsources -name $app0Name -path $tclPath/src/$app0Name
app create -name $app1Name -platform $xsaName -domain standalone_domain -template "Empty Application"
importsources -name $app1Name -path $tclPath/src/$app1Name
app create -name $app2Name -platform $xsaName -domain standalone_domain -template "Empty Application"
importsources -name $app2Name -path $tclPath/src/$app2Name
#Build platform project
platform generate
#Build application project
append app0Name "_system"
sysproj build -name $app0Name
append app1Name "_system"
sysproj build -name $app1Name
append app2Name "_system"
sysproj build -name $app2Name





