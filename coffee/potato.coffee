$ ->

  potatoCount = 0
  potatoUpgrades = {}
  upgradeCooficients = {}
  upgradeCosts = {}
  upgradeTypes = ["farm","factory","kappa"]
  upgradeNumbers = [2,5,10]
  upgradeCostsN = [10,100,200]
  modifier = 0

  initStuff = ->
    for index in [0...3]
      potatoUpgrades[upgradeTypes[index]] = 0
      upgradeCooficients[upgradeTypes[index]] = upgradeNumbers[index]
      upgradeCosts[upgradeTypes[index]] = upgradeCostsN[index]  

  initStuff()

  showDict = ->
    console.log upgradeCooficients
    console.log potatoUpgrades

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
    $( "#label").text("Potatoes: #{countConvert(potatoCount)}")
    $( "#ps").text("Potatoes/second: #{modifier}")
   
  setInterval (potatoTick), 1000
  setInterval (uiUpdate), 100

  upgradeInsert = (type) ->
    unless potatoCount < upgradeCosts[type]
      potatoUpgrades[type] = potatoUpgrades[type]+=1
      potatoCount -= upgradeCosts[type]
      upgradeCosts[type] *= 2
      upgradeCooficients[type] *= 1.5
      resCount = potatoUpgrades[type]
      $( "##{type}Count").text("#{type}: #{resCount}")
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
    $( "#upgradeBtnF" ).attr("value", "Build a Farm. Cost: #{upgradeCosts["farm"]}")
    $( "#upgradeBtnFa" ).attr("value", "Build a Factory. Cost: #{upgradeCosts["factory"]}")
    $( "#upgradeBtnK" ).attr("value", "Build a Kappa. Cost: #{upgradeCosts["kappa"]}")
  

  $( "#upgradeBtnFa" ).on( "click", ->
    upgradeInsert("factory"))
  $( "#upgradeBtnK" ).on( "click", ->
    upgradeInsert("kappa"))
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

