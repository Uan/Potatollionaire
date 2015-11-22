$ -> 
  initUi = ->
   setInterval (uiUpdate), 200
  
  displayBuildings = ->
    $( "#resourceDisplay").text("")
    for building in buildings
        $( "#resourceDisplay").append("<p>#{building.getName()}: #{building.getNum()}</p>")
        
  buttonValues = ->
    $( "#upgradeBtnF" ).attr("value", "Build a Farm. Cost: #{countConvert(upgradeCosts["farm"])}")
    $( "#upgradeBtnFa" ).attr("value", "Build a Factory. Cost: #{countConvert(upgradeCosts["factory"])}")
    $( "#upgradeBtnK" ).attr("value", "Build a Kappa. Cost: #{countConvert(upgradeCosts["kappa"])}")
    $( "#upgradeBtnC" ).attr("value", "Build a Copy machine. Cost: #{countConvert(upgradeCosts["copy_machine"])}")


  $( "#upgradeBtnFa" ).on( "click", ->
    upgradeInsert("factory",100,10))
  $( "#upgradeBtnK" ).on( "click", ->
    upgradeInsert("kappa","user"))
  $( "#upgradeBtnF" ).on( "click", ->
    upgradeInsert("farm",10,2))
  $( "#upgradeBtnC" ).on( "click", ->
    upgradeInsert("copy_machine","user"))

  $( "#potatoGet" ).on( "click", ->
    potatoGet())

  $( ":button" ).on( "click", ->
    uiUpdate())
  $( "#sacrifice1" ).on( "click", ->
    sacrifice(1))
  $("#spell1").on("click", ->
    spells["golem"].cast())
    
  uiUpdate = ->
    $( "#label").text("Potatoes: #{countConvert(potatoCount)}")
    $( "#ps").text("Potatoes/second: #{countConvert(modifier)}")
    $("#mana").text("mana: #{mana}")
    $("#spellmod").text("#{countConvert magicMultiplier}")
    displayBuildings()
    # displayAchievements()
    #buttonValues()
  
  initStuff()
  initUi()