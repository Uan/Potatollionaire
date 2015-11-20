$ ->
  tickNum = 0
  potatoCount = 0
  potatoUpgrades = {}
  upgradeCooficients = {}
  upgradeCosts = {}
  upgradeTypes = ["farm","factory","kappa","copy_machine"]
  upgradeNumbers = [2,5,10,0]
  upgradeCostsN = [10,100,200,10]
  modifier = 0
  magicMultiplier = 1
  mana = 0
  spells = {}
  activeSpells = {}

  initStuff = ->
    for index in [0..4]
      potatoUpgrades[upgradeTypes[index]] = 0
      upgradeCooficients[upgradeTypes[index]] = upgradeNumbers[index]
      upgradeCosts[upgradeTypes[index]] = upgradeCostsN[index]  

  displayUpgrade = ->
    $( "#resourceDisplay").text("")
    for i in [0..upgradeTypes.length-1]
      type = upgradeTypes[i]
      if potatoUpgrades[type] > 0
        $( "#resourceDisplay").append("<p>#{type}: #{potatoUpgrades[type]}</p>")  

  copyMachine = ->
    console.log("Copy Machine has been accessed")
    if tickNum == 5
      for i in [0...potatoUpgrades["copy_machine"]] 
          prob = Math.floor(Math.random() * 100)
          if prob <= 80
           upgradeInsert("farm","cm")          
          else if prob <= 95
            upgradeInsert("factory","cm")    
          else
            upgradeInsert("kappa","cm")
          tickNum = 0
    else 
      tickNum+=1
          

  showDict = ->
  	console.log upgradeCooficients
  	console.log potatoUpgrades

  potatoGet  = ->
  	potatoCount += 1
  	$( "#label").text("Potatoes: #{countConvert(potatoCount)}")


  potatoTick = ->
  	modifier = 0
  	for type in upgradeTypes
  			modifier += potatoUpgrades[type]*upgradeCooficients[type]
  	potatoCount += modifier*magicMultiplier

  uiUpdate = ->
    $( "#label").text("Potatoes: #{countConvert(potatoCount)}")
    $( "#ps").text("Potatoes/second: #{countConvert(modifier)}")
    $("#mana").text("mana: #{mana}")
    $("#spellmod").text("#{magicMultiplier}")
    displayUpgrade()


  setInterval (potatoTick), 1000
  setInterval (copyMachine), 1000
  setInterval (uiUpdate), 200


  upgradeInsert = (type,source) ->
    if potatoCount >= upgradeCosts[type] and source == "user"
      console.log("user has made a #{type}")
      potatoUpgrades[type] = potatoUpgrades[type]+=1
      potatoCount -= upgradeCosts[type]
      upgradeCosts[type] *= 2
      upgradeCooficients[type] *= 1.15
    
    else if source == "cm" 
      potatoUpgrades[type] = potatoUpgrades[type]+=1
      upgradeCooficients[type] *= 1.15
    
    buttonValues()


  roundToTwo = (number) ->
    return Math.round(number*10)/10
      
  countConvert = (number) ->
    if number >= 1000000000
      return roundToTwo(number/1000000000) + "B"
    else if number >= 1000000
      return roundToTwo(number/1000000) + "M"
    else if number >= 1000
      return roundToTwo(number/1000) + "K"
    else return roundToTwo(number)
  


  buttonValues = ->
    $( "#upgradeBtnF" ).attr("value", "Build a Farm. Cost: #{countConvert(upgradeCosts["farm"])}")
    $( "#upgradeBtnFa" ).attr("value", "Build a Factory. Cost: #{countConvert(upgradeCosts["factory"])}")
    $( "#upgradeBtnK" ).attr("value", "Build a Kappa. Cost: #{countConvert(upgradeCosts["kappa"])}")
    $( "#upgradeBtnC" ).attr("value", "Build a Copy machine. Cost: #{countConvert(upgradeCosts["copy_machine"])}")
  

  $( "#upgradeBtnFa" ).on( "click", ->
    upgradeInsert("factory","user"))
  $( "#upgradeBtnK" ).on( "click", ->
    upgradeInsert("kappa","user"))
  $( "#upgradeBtnF" ).on( "click", ->
    upgradeInsert("farm","user"))
  $( "#upgradeBtnC" ).on( "click", ->
    upgradeInsert("copy_machine","user"))
  
  $( "#potatoGet" ).on( "click", ->
    potatoGet())

  $( ":button" ).on( "click", ->
    uiUpdate())
  initStuff()
