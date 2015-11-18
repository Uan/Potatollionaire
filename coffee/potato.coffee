$ ->
  potatoCount = 0
  potatoUpgrades = {}
  upgradeCooficients = {}
  upgradeCosts = {}
  upgradeTypes = ["farm","factory","kappa"]
  upgradeNumbers = [2,5,10]
  upgradeCostsN = [10,100,200]
  modifier = 0
  magicMultiplier = 1
  mana = 0
  spells = {}
  activeSpells = {}

  initStuff = ->
    for index in [0...3]
      potatoUpgrades[upgradeTypes[index]] = 0
      upgradeCooficients[upgradeTypes[index]] = upgradeNumbers[index]
      upgradeCosts[upgradeTypes[index]] = upgradeCostsN[index]  

  

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
  	potatoCount += modifier*magicMultiplier

  uiUpdate = ->
    $( "#label").text("Potatoes: #{countConvert(potatoCount)}")
    $( "#ps").text("Potatoes/second: #{modifier}")
    $("#mana").text("mana: #{mana}")
  setInterval (potatoTick), 1000
  setInterval (uiUpdate), 200

  upgradeInsert = (type) ->
    unless potatoCount < upgradeCosts[type]
      potatoUpgrades[type] = potatoUpgrades[type]+=1
      potatoCount -= upgradeCosts[type]
      upgradeCosts[type] *= 2
      upgradeCooficients[type] *= 1.5
      resCount = potatoUpgrades[type]
      $( "##{type}Count").text("#{type}: #{resCount}")
      buttonValues()
  countConvert = (number) ->
    if number >= 1000000000
      return number/1000000000 + "B"
    else if number >= 1000000
      return number/1000000 + "M" 
    else if number >= 1000
      return number/1000 + "K"
    else return number
  
  class Spell
    constructor: (@name) ->
      @description
      @cost
      @duration
      duration_cur :  0
    expiration: ->
      @duration_cur=0 
      console.log("sadness")
    tick: ->
      console.log('something')
      if @duration_cur > 0
        @effect()
        @duration_cur -= 1
        setTimeout(tick,1000)
      else expiration
    cast: ->
      @tick
      unless mana<@cost
        @duration_cur = @duration
        mana -=@cost
        @tick

  class SummonGolem extends Spell
    constructor: ->
      super("golem")
    description: "summon potato golem to boost your production"
    cost: 10
    duration: 60
    cast: ->
      super
      magicMultiplier +=0.15
    expiration: ->
      magicMultiplier -=0.15
  spells["golem"] = new SummonGolem

  sacrifice = (n) ->
    unless potatoCount<n
      mana+=n
      potatoCount-=n

  $( "#sacrifice1" ).on( "click", ->
    sacrifice(1))
  $("#spell1").on("click", ->

    spells["golem"].cast())
 
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
  initStuff()
