$ ->
  potatoCount = 0
  potatoUpgrades = {}
  upgradeTypes = ["farm","factory","kappa"]

  for type in upgradeTypes
    potatoUpgrades[type] = 0

  potatoGet  = ->
  	potatoCount += 1
  	console.log potatoCount
  	$( "#label").text("Potatoes: #{potatoCount}")

  potatoTick = ->
  	modifier = 0
  	for type in upgradeTypes
  		if type == "farm"
  			modifier += potatoUpgrades[type]*2
  		if type == "factory"
  			modifier += potatoUpgrades[type]*5
  		if type == "kappa"
  			modifier += potatoUpgrades[type]*10
  	potatoCount += modifier
  	$( "#label").text("Potatoes: #{potatoCount}")
  	$( "#ps").text("Potatoes/second: #{modifier}")
  	console.log potatoCount

  setInterval (potatoTick), 1000

  upgradeInsert = (type) ->
    potatoUpgrades[type] = potatoUpgrades[type]+=1
    console.log potatoUpgrades[type]
    
  $( "#upgradeBtnF" ).on( "click", ->
    upgradeInsert("farm"))
  $( "#upgradeBtnFa" ).on( "click", ->
    upgradeInsert("factory"))
  $( "#upgradeBtnK" ).on( "click", ->
    upgradeInsert("kappa"))
  $( "#potatoGet" ).on( "click", ->
    potatoGet())

