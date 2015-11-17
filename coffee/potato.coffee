$ ->
  potatoCount = 0
  potatoUpgrades = {}
  upgradeCooficients = {}
  upgradeTypes = ["farm","factory","kappa"]
  upgradeNumbers = [2,5,10]
  modifier = 0
  
  showDict = ->
  	console.log upgradeCooficients
  	console.log potatoUpgrades
#showDict method is to display debug values in the console
  setValues = ->
  	for index in [0...3]
    	potatoUpgrades[upgradeTypes[index]] = 0
    	upgradeCooficients[upgradeTypes[index]] = upgradeNumbers[index]
 		
  setValues()  	
#this thing sets the values in the dictinaries 
  potatoGet  = ->
  	potatoCount += 1
  	showDict()
  	$( "#label").text("Potatoes: #{potatoCount}")

  potatoTick = ->
  	modifier = 0
  	for type in upgradeTypes
  			modifier += potatoUpgrades[type]*upgradeCooficients[type]
  	potatoCount += modifier

  uiUpdate = ->
  	$( "#label").text("Potatoes: #{potatoCount}")
  	$( "#ps").text("Potatoes/second: #{modifier}")
#$swag
  setInterval (potatoTick), 1000
  setInterval (uiUpdate), 100
  
  upgradeInsert = (type) ->
    potatoUpgrades[type] = potatoUpgrades[type]+=1
    
    
  $( "#upgradeBtnF" ).on( "click", ->
    upgradeInsert("farm"))
  $( "#upgradeBtnFa" ).on( "click", ->
    upgradeInsert("factory"))
  $( "#upgradeBtnK" ).on( "click", ->
    upgradeInsert("kappa"))
  $( "#potatoGet" ).on( "click", ->
    potatoGet())

  $( ":button" ).on( "click", ->
    uiUpdate())
  
