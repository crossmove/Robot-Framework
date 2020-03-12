***Settings***
Resource    OperatingSystem
Resource   ResourceFile1.robot
Library    LibraryFile1.py
Variables    callmethod.py

##http://robotframework.org/robotframework/latest/libraries/BuiltIn.html

##Notes
    ##${Binary1}=	Convert To Binary	10    #after variable use direct = and then give two whitespaces to avoid confusing.

# # # Integer Number
# # # ${number}=  Set Variable  ${32}
###hello HI

***Variables***
#Variables   Config.py

***Test Cases***

Evaluate_Random_Test
#Evaluate, Run Keyword If , Should Be True ,etc these keywords expression are 
#uses python eval function internally    
    ${random int} =	Evaluate	random.randint(0, 5)	modules=random
    Log To Console   ${random int}

SpecialVariable_Test
    ${output}  Set Variable  PASSFAIL
    Run Keyword If	'FAIL'  in  ${output}	Hello
    #Run Keyword If	'FAIL'  in  ${output}  Log to console  Output contains FAIL
    Should Be True	len($result) > 1 and $result[1] == 'OK'	

MultiLine_Seperator
    #tab seperator
    ${first} =	Catenate	SEPARATOR=\t	Not in second	Same	Differs	Same

    #new Line seperator
    ${second} =	Catenate	SEPARATOR=\n	Same	Differs2	Same	Not in first
    ${second} =	Catenate	SEPARATOR=\r\n	Same	Differs2	Same	Not in first   

    Should Be Equal	${first}	${second}

CallMethod_Test
    ##Calling Python class methods,  here it is callmethod.py
    ##in the callmethod.py file we created a object, sobject=simple()
    ${browser}=   call method    ${sobject}    Browser
    ${SiteUrl}=  call method  ${sobject}   URL
    Log To Console  ${browser}  stream=STDOUT  no_newline=False
    Log To Console  ${SiteUrl}  stream=STDOUT  no_newline=False
##  Refer https://stackoverflow.com/questions/43441353/calling-a-particular-method-from-python-module-in-robot-framework

Catenate_Test
    ${str1} =	Catenate	Hello	world	
    ${str2} =	Catenate	SEPARATOR=---	Hello	world
    ${str3} =	Catenate	SEPARATOR=	Hello	world
    Log To Console   ${str1} 
    Log To Console   ${str2} 
    Log To Console   ${str3} 

# # https://stackoverflow.com/questions/56461983/how-to-exit-from-for-loop-in-robot-framework
# # https://stackoverflow.com/questions/23863264/
# # how-to-write-multiple-conditions-of-if-statement-in-robot-framework

For Loop
    FOR    ${value}    IN    @{Hero}
        Do your stuff
        Exit For Loop IF    "${value}" == "${Batman}"
        Do your stuff
    END

Exit For Loop_Test
    #https://stackoverflow.com/questions/36328595/how-to-write-a-loop-while-in-robot-framework
    :FOR    ${i}    IN RANGE   1  10
    \    Exit For Loop If    ${i} == 5
    \    Log To Console    ${i}
    Log    Exited

    #or

    FOR    ${i}    IN RANGE   1  10
        Exit For Loop If    ${i} == 5
        Log To Console    ${i}
    END
    Log    Exited

Continue For Loop IF_Test
#In this test the printing 3 is skipped.
    :FOR	${var}	IN RANGE  1  5
    \    Continue For Loop If  '${var}' == '3'
    \   Log To Console  ${var}  stream=STDOUT  no_newline=False

Continue For Loop_TestCase
#here the keyword  ""Continue For Loop" is executed on condition becomes true
    :FOR	${var}	IN range  1  5
    \    Run Keyword If	'${var}' == '1'	Continue For Loop
    \   log to console	${var}

Convert To Binary_Boolean_Bytes_TestCase
    ${Binary1}=	Convert To Binary	10      
    ${Bool1}=  Convert To Boolean  True      #(case-insensitive) 
    #Convert To Bytes
    #Convert To Hex
    ${result}=  Convert To Integer	100

    ${result}=  Convert To Number	42.512		# Result is 42.512
    ${result}=  Convert To Number	42.512	1	# Result is 42.5
    ${string1}=  convert to String   21

CreateDictionay_TestCase
     &{dict}=	Create Dictionary  key1=value1  name=pradeep     
     Log To Console  ${dict.key1}
     Log To Console  ${dict.name}
     #Compariso of dictionaries, below code is true case.
     Should Be True 	${dict} == {'key1': 'value1', 'name': 'pradeep'}     

CreateList_TestCase
    @{list} =	Create List	a	b	c
    ${scalar} =	Create List	11	22	33
    ${ints} =	Create List	    ${1}	${2}	${3}
    Log To Console  @{list}[0]
    Log To Console  @{scalar}[1]
    Log To Console  @{ints}[2]

Evaluate_TestCase
    ${result}=  Set Variable  5
    ${status} =	Evaluate	0 < ${result} < 10	# Would also work with string '3.14'    
    ${random} =	Evaluate	random.randint(20, 50)	modules=random, sys
    Log To Console  abc

Evaluate_Namespace_TestCase
    ${namespace1} =	Create Dictionary	x=${4}	y=${2}
    #The x value is collected from the namespace which contains a dictionary. Rarely we use this kind of scenario
    ${result} =	Evaluate	x*10 + y	namespace=${namespace1}
    Log To Console  ${result}

Fail_Keyword_Test 
    Run Keyword If  'a' == 'b'  log to console  TestCaseIsPassing  ELSE  FAIL   Failure Message Not equal
    Log To Console  hi  stream=STDOUT  no_newline=False


#The test or suite where this keyword is used fails with the provided message, 
#and subsequent tests fail with a canned message. Possible teardowns will nevertheless be executed.
#See Fail if you only want to stop one test case unconditionally.
FatalError_Test 
    Run Keyword If  'a' == 'b'  log to console  TestCaseIsPassing  ELSE  Fatal Error   FatalErrorStopsExecutionOfEntireSuite
    Log To Console  hi  stream=STDOUT  no_newline=False

Get Count TestCase
    #here search keyword is occured 2 times in the string. Prints 2
    ${count} =	Get Count	this is my search and search message	search
    Log To Console  ${count}  stream=STDOUT  no_newline=False

Get Length Test
    ${length} =	Get Length	12345678
    #Prints 8
    Log To Console  ${length}  stream=STDOUT  no_newline=False
    Should Be Equal As Integers	${length}	8

#todo, advance concept
# Get Library Instance

Get Time_Test
    ${time1} =	Get Time        #2020-03-09 20:52:32
    @{time2} =	Get Time	year month day hour min sec     #2020,03,09,20,52,32
    ${year1}	${seconds1} =	Get Time	seconds and year

Get Variable Value
    ${b}    Set Variable  21
    #if ${a} does not exist, it will return 2nd parameter    
    ${x} =	Get Variable Value	${a}	SomedefaultValue        #SomedefaultValue

    ${y} =	Get Variable Value	${a}	${b}                    #21
    Log To Console  ${x}
    Log To Console  ${y}

#todo   advanced concept
#Get Variables

#This functionality allows dynamic importing of libraries while tests are running. 
#That may be necessary, if the library itself is dynamic and not yet available
# this keyword is not executed by me. 
Import Library
    Import Library	MyLibrary			
    Import Library	${CURDIR}/../Library.py	arg1	named=arg2	
    Import Library	${LIBRARIES}/Lib.java	arg	WITH NAME	JavaLib     #WITH NAME syntax can be used to give a custom name to the imported library.l

#Imports the Resoure into testsuite like we are setting at the top of this file in Settings section. 
# / forward slash can be used as path seperator for all operating system.  ex: c:/foder1
#Below code not executed.
Import Resource
    Import Resource	${CURDIR}/resource.txt
    Import Resource	${CURDIR}/../resources/resource.html
    Import Resource	found_from_pythonpath.robot

# #Variables imported with this keyword are set into the test suite scope similarly
# #when importing them in the Setting table using the Variables setting.
# this functionality can thus be used to import new variables, for example, for each test in a test suite.
#https://github.com/robotframework/robotframework/blob/master/doc/userguide/src/CreatingTestData/ResourceAndVariableFiles.rst
Import Variables
    Import Variables	${CURDIR}/pythonvariablefile.py
    Log To Console  ${name}  stream=STDOUT  no_newline=False    #pradeep Kumar KR  
    #Import Variables	${CURDIR}/../vars/env.py	arg1	arg2


if  else if
    Run Keyword If "${id}"=="1" Method1  
    ... ELSE IF  "${id}"=="2"  Method2  
    ... ELSE IF "${id}"=="3" Method3

Press Keys
    Press Keys None CTRL+ARROW_RIGHT
    Press Keys  None    ENTER

Run Keyword if
    Run Keyword If    '${Status1}'==first and '${Status2}'==second  Wait_And_Click_Element  ${elementXPath}
            ...    ELSE
            ...    FAIL  Failure Message



#Test will fail if the lenght count does not matches with the string lenthg
Length Should Be
    Length Should Be    12345  6  msg-LengthIsNotCorrect
    Log To Console  hi  stream=STDOUT  no_newline=False

#Logs multiple values examples dictionary, list and mutli string passed
Log Many    
    ${var}  Set Variable  Pradeep
    @{list}     Create List  1  2   3   4
    &{dict}     Create Dictionary  key1=value1  key2=value2
    Log Many    Hello   ${var}
    Log Many    @{list}     &{dict}      

#Logs all variables in the current scope with given log level, including global , curdir , execdir
# the variables we see in the left side of the vs code during debugging.
Log Variables
    ${var1}     Set Variable  first
    ${var2}     Set Variable  second
    ${var3}     Set Variable  third
    Log Variables  level=INFO

#Does absolutely nothing.
# No Operation		

# Skips rest of the current test, setup, or teardown with PASS status.
#Pass Execution

# todo read
# Regexp Escape

# todo read
# Reload Library

#Removes given tags from the current test or all tests in a suite.
Remove Tags
    [Tags]  p1testcase  regression-sprint1  Python  
    Remove Tags	p1testcase	regression-*	?ython


Repeat Keyword
    Repeat Keyword  5 times  log to console  pradeep
    Repeat Keyword	5 times	 Press Keys  TAB		    # No of times
    Repeat Keyword	${var}	Press Keys  TAB		        # With variable count
    Repeat Keyword	2 minutes	Press Keys  TAB         # Until 2 minutes

# Replace ${NAME}  in template.txt with local ${NAME} variable value pradeep
#this test is not executing giving Get File keyword not found.
Replace Variables
    ${NAME}     Set Variable  Pradeep
    GetFile  ${CURDIR}/template.txt
    #${template} =	Get File	${CURDIR}/template.txt
    ${message} =	Replace Variables	${template}
    Log To Console  ${message}  stream=STDOUT  no_newline=False

#Run Keyword


#Runs the keyword and continues execution even if a failure occurs.
Run Keyword And Continue On Failure
    Run Keyword And Continue On Failure 	Fail	This is a stupid example
    Log To Console    Hello this line is still executed	

#todo read
# Run Keyword And Expect Error
# Run Keyword And Ignore Error

## its failing need to check, as per my understanding run the keyword returned by the method called. 
## Hello1 keyword returned Hello2, run Hello2 as keyword. 
Run Keyword And Return
    Run Keyword And Return  Hello1    

#Run Keyword And Return If

# Returns true or false, if the keyword executes without error it returns true else fail
# not to be confused with the return value of the keyword, its totally different concept.
Run Keyword And Return Status
    ${status}=  Run Keyword And Return Status   Hello1
    Log to console  Status=${status}

#Runs the given keyword with the given arguments, if condition is true.
Run Keyword If
    ${status}	${value} =	Run Keyword And Ignore Error	My Keyword
    Run Keyword If	'${status}' == 'PASS'	Some Action	arg
    Run Keyword Unless	'${status}' == 'PASS'	Another Action

# Executes all the given keywords in a sequence.
# Keywords can also be run with arguments using upper case AND as a separator between keywords.
Run Keywords
    Run Keywords	Initialize database	db1	AND	Start servers	server1	server2	
    Run Keywords	Initialize database	${DB NAME}	AND	Start servers	@{SERVERS}	AND	Clear logs
    Run Keywords	${KW}	AND	@{KW WITH ARGS}	

	
Makes a variable available globally in all tests and suites.
#Variables set with this keyword are globally available in all subsequent test suites,
# test cases and user keywords.
#In practice setting variables with this keyword has the same effect as using command line options --variable and --variablefile.
Set Global Variable
    Set Global Variable  @{globalList}  1   2
    
    Log To Console  @{globalList}[0]   #1
    Log To Console  ${globalList}[0]   #1
    Log To Console  @{globalList}[1]   #2

    Set Global Variable  &{globalDict}  id=1    name=pradeep
    Log To Console  @{globalDict}[1]        #name
    Log To Console  ${globalDict.name}      #pradeep
    Log To Console  hi


# Set test Variable

# Set Library Search Order

# Set Suite Variable

#Adds given tags for the current test or all tests in a suite.
Set Tags

#Makes a variable available everywhere within the scope of the current task.
Set Task Variable

## after the execution completion we can see the message in the console output. 
Set Test Message
    Set Test Message	My message	
    Set Test Message	is continued.	append=yes  

# available  in the scope of current test
Set Test Variable
    Set Test Variable   ${testvar}  1

#Returns the given values which can then be assigned to a variables.
Set Variable
    ${hi} = 	Set Variable	Hello, world!		
    ${hi2} =	Set Variable	I said: ${hi}		
    ${var1}  ${var2} =	Set Variable	Hello	world
    @{list} =	Set Variable	1  2  3  4	
    ${item1}	${item2} =	Set Variable	${hi}  ${hi2}
    Log To Console  hi  stream=STDOUT  no_newline=False


Set Variable If
    ${var1} =	Set Variable If	 "1" == '1'  1	  s2      #1
    Log To Console  hi

    ${rc}=  Set Variable  2
    ${var} =	Set Variable If		
    ...	${rc} == 0	zero	
    ...	${rc} == 1	one	
    ...	${rc} == 2	two	            ##this line is executed
    ...	${rc} == 3	three
    ...	${rc} > 2	greater than two	
    ...	${rc} < 0	less than zero	
    Log To Console  ${rc}  stream=STDOUT  no_newline=False      #2
    Log To Console  ${rc}

Should Be Empty
    ${var1}=    Set Variable  ${EMPTY}
    Should Be Empty  ${var1}  msg=None


Should Be Equal
    Should Be Equal  1  1
    Should Be Equal  actual  ACTUAL  ignore_case=True

Should Be Equal As Integers
    Should Be Equal As Integers  42  ${42}  Error message

Should Be Equal As Numbers
    Should Be Equal As Numbers	1.123	1.1	precision=1	# Passes

Should Be Equal As Strings

Should Be True
    ${rc}=  Set Variable  5
    ${status}=  Set Variable  PASS
    ${number}=  Set Variable  32
    @{list}=  Create List  1    2
    Should Be True	${rc} < 10	
    Should Be True	'${status}' == 'PASS'	# Strings must be quoted
    Should Be True	${number}	# Passes if ${number} is not zero
    Should Be True	${list}	# Passes if ${list} is not empty
    Log To Console  hi  stream=STDOUT  no_newline=False

Should Contain
    Should Contain	${output}	PASS
    Should Contain	${some list}	value	ignore_case=True	

Fails if container does not contain any of the *items.
Should Contain Any
    Should Contain Any	${list}	item 1	item 2	item 3

Should Contain X Times
    Should Contain X Times	${output}	hello	2	
    Should Contain X Times	${some list}	value	3	ignore_case=True

#Should Start With

#Sleep

	
##Fails unless the given variable exists within the current scope.

#Variable Should Exist

#Variable Should Not Exist

#If retry is given as timeout, it must be in Robot Framework's time format (e.g. 1 minute, 2 min 3 s, 4.5) 
# Runs the specified keyword and retries if it fails. This can be used for element visible wait time 
Wait Until Keyword Succeeds    #retry, retry_interval,   name,        *args
    Wait Until Keyword Succeeds	2 min	5 sec	        My keyword 	argument
    ${result} =	Wait Until Keyword Succeeds	3x	200ms	My keyword



#Private Keywords
***Keywords***
Hello
    Log To Console  hello  stream=STDOUT  no_newline=False  

Hello1
    Log To Console  Hi  stream=STDOUT  no_newline=False    

Hello2
    Log To Console  hello2  stream=STDOUT  no_newline=False  

RunKeywordReturnExample
    #[Arguments]     ${a}   ${b}
    [Return]    ${a}+${b}

#https://marketplace.visualstudio.com/items?itemName=JacobPhilip.danfoss-robotframework-debug


