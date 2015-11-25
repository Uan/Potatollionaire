$ -> 
  initUi = ->

    $("#buttons").append("<input id='bFarm' type='button' value='Build a farm: 10'/>")
    $("#buttons").append("<input id='bFactory' type='button' value='Build a factory: 100'/>")    
    $("#buttons").append("<input id='bKappa' type='button' value='Build a kappa: 500'/>")    
    #$("#buttons").append("<input id='#bCopy' type='button' value='Build a farm: 10'/>")
    listeners()
    setInterval (uiUpdate), 200
    
  
  displayBuildings = ->
    $( "#resourceDisplay").text("")
    for building in buildings
        $( "#resourceDisplay").append("<p>#{building.getName()}: #{building.getNum()}</p>")
  listeners = ->
    $("#bFactory").on( "click", ->
      buildingInsert("factory",100,10,"bFactory","Build a factory"))
    $("#bKappa").on( "click", ->
      buildingInsert("kappa",500,30,"bKappa","Build a farm"))
    $("#bFarm").on( "click", ->
      buildingInsert("farm",10,2,"bFarm","Build a kappa"))
    #WIP$( "#bCopy" ).on( "click", ->
    #buildingInsert("copy_machine","user","bCopy"))
    $( "#potatoGet" ).on( "click", ->
      potatoGet())
    $( "button" ).on( "click", ->
      uiUpdate())
    $( "#sacrifice1" ).on( "click", ->
      sacrifice(1))
    $("#spell1").on("click", ->
      spells["golem"].cast())
    $("#testUpgrade").on('click',->
      upgrades[0].purchase())
      
  uiUpdate = ->
    for building in buildings
      $("#{building.getButtonId()}").attr("value", "#{building.getDesc()} : #{numberShortener(building.getCost())}")
    $( "#label").text("Potatoes: #{numberShortener(potatoCount)}")
    $( "#ps").text("Potatoes/second: #{numberShortener(modifier)}")
    $("#mana").text("mana: #{mana}")
    $("#spellmod").text("#{numberShortener magicMultiplier}")
    displayBuildings()
    # displayAchievements()
    #buttonValues()
  
  initStuff()
  initUi()

  

  