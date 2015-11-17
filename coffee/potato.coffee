potatoCount = 0
potatoUpgrades = {}
upgradeTypes = ["farm","factory","kappa"]
for type in upgradeTypes
	potatoUpgrades[type] = 0

potatoInit = ->
  potatoCount += 1
  console.log potatoCount
setInterval (potatoInit), 2000
window.farmInsert = ->
	type = "farm"
	potatoUpgrades[type] = potatoUpgrades[type]+=1
	console.log potatoUpgrades[type]
	console.log "A farm has been added"

window.factoryInsert = ->
	type = "factory"
	potatoUpgrades[type] = potatoUpgrades[type]+=1
	console.log potatoUpgrades[type]
	console.log "A factory has been added"

window.whateverInsert = ->
	type = "kappa"
	potatoUpgrades[type] = potatoUpgrades[type]+=1
	console.log potatoUpgrades[type]
	console.log "A kappa has been added"

