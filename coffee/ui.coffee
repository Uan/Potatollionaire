$ -> 
  initUi = ->
   setInterval (uiUpdate), 200
  
  displayBuildings = ->
    $( "#resourceDisplay").text("")
    for i in [0..upgradeTypes.length-1]
      type = upgradeTypes[i]
      if potatoUpgrades[type] > 0
        $( "#resourceDisplay").append("<p>#{type}: #{potatoUpgrades[type]}</p>")
        
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
    buttonValues()
  
  initStuff()
  initUi()