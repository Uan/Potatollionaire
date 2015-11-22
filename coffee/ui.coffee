$ -> 
  initUi = ->

    $("#buttons").append("<input id='bFarm' type='button' value='Build a farm: 10'/>")
    $("#buttons").append("<input id='bFactory' type='button' value='Build a factory: 100'/>")    
    $("#buttons").append("<input id='bKappa' type='button' value='Build a kappa: 500'/>")    
    #$("#buttons").append("<input id='#bCopy' type='button' value='Build a farm: 10'/>")        
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

  $( ":button" ).on( "click", ->
    uiUpdate())
  $( "#sacrifice1" ).on( "click", ->
    sacrifice(1))
  $("#spell1").on("click", ->
    spells["golem"].cast())
    
  uiUpdate = ->
    for building in buildings
      $("##{building.getButtonId()}").attr("value", "#{building.getDesc()} : #{countConvert(building.getCost())}")
    $( "#label").text("Potatoes: #{countConvert(potatoCount)}")
    $( "#ps").text("Potatoes/second: #{countConvert(modifier)}")
    $("#mana").text("mana: #{mana}")
    $("#spellmod").text("#{countConvert magicMultiplier}")
    displayBuildings()
    # displayAchievements()
    #buttonValues()
  
  initStuff()
  initUi()
  listeners()
  

  