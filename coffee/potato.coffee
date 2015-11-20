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
    for index in [0...4]
      potatoUpgrades[upgradeTypes[index]] = 0
      upgradeCooficients[upgradeTypes[index]] = upgradeNumbers[index]
      upgradeCosts[upgradeTypes[index]] = upgradeCostsN[index]  

  
  copyMachine = ->
    tickNum+=1
    if tickNum == 5
      prob = Math.floor(Math.random() * 100)
      if prob <= 80
        potatoUpgrades["farm"] += 1
        tickNum = 0
      else if prob <= 95
        potatoUpgrades["factory"] += 1
        tickNum = 0
      else
        potatoUpgrades["kappa"] += 1
        tickNum = 0

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
  setInterval (potatoTick), 1000
  setInterval (copyMachine), 3000
  setInterval (uiUpdate), 200

  upgradeInsert = (type) ->
    unless potatoCount < upgradeCosts[type]
      potatoUpgrades[type] = potatoUpgrades[type]+=1
      potatoCount -= upgradeCosts[type]
      upgradeCosts[type] *= 2
      upgradeCooficients[type] *= 1.15
      resCount = potatoUpgrades[type]
      $( "#resourceDisplay").append("<p>#{type}: #{resCount}</p>")
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
  
  class Spell
    constructor: (@name) ->
      @description
      @cost
      @duration
      duration_cur :  0
    effect: =>
      @tick()
    expiration: =>
      @duration_cur=0 
    tick: =>
      if @duration_cur > 0
        @duration_cur -= 1
        setTimeout(@tick,1000)
      else @expiration()
    cast: =>
      unless mana<@cost
        @duration_cur = @duration
        mana -=@cost
        @effect()
        

  class SummonGolem extends Spell
    constructor: ->
      super("golem")
    description: "summon potato golem to boost your production"
    cost: 10
    duration: 60
    effect: =>
      super
      magicMultiplier +=0.15
    expiration: =>
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
    $( "#upgradeBtnF" ).attr("value", "Build a Farm. Cost: #{countConvert(upgradeCosts["farm"])}")
    $( "#upgradeBtnFa" ).attr("value", "Build a Factory. Cost: #{countConvert(upgradeCosts["factory"])}")
    $( "#upgradeBtnK" ).attr("value", "Build a Kappa. Cost: #{countConvert(upgradeCosts["kappa"])}")
    $( "#upgradeBtnC" ).attr("value", "Build a Copy machine. Cost: #{countConvert(upgradeCosts["copy_machine"])}")
  

  $( "#upgradeBtnFa" ).on( "click", ->
    upgradeInsert("factory"))
  $( "#upgradeBtnK" ).on( "click", ->
    upgradeInsert("kappa"))
  $( "#upgradeBtnF" ).on( "click", ->
    upgradeInsert("farm"))
  $( "#upgradeBtnC" ).on( "click", ->
    upgradeInsert("copy_machine"))
  
  $( "#potatoGet" ).on( "click", ->
    potatoGet())

  $( ":button" ).on( "click", ->
    uiUpdate())
  initStuff()
