$ ->
  potatoCount = 0
  potatoUpgrades = {}
  upgradeTypes = ["farm","factory","kappa"]
  for type in upgradeTypes
    potatoUpgrades[type] = 0

  potatoInit = ->
    potatoCount += 1
    console.log potatoCount
  setInterval (potatoInit), 2000

  upgradeInsert = (type) ->
    console.log potatoUpgrades[type]
    potatoUpgrades[type] = potatoUpgrades[type]+=1
    


  $( "#upgradeBtnF" ).on( "click", ->
    upgradeInsert("farm"))
  $( "#upgradeBtnFa" ).on( "click", ->
    upgradeInsert("factory"))
  $( "#upgradeBtnK" ).on( "click", ->
    upgradeInsert("kappa"))
