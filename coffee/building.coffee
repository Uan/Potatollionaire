buildings = []
class Building
	constructor: (@name, @cost, @modifier) ->
		@built = false
		@cost
		@description
		@modifier
		@amount = 0
	calculatePrice: ->
		if @amount > 0
			console.log("HAAAAAAAAAA")
			@cost = @cost*1.15
		return @cost
	purchase: -> 
		@built = true
		if potatoCount >= @calculatePrice()
			@amount+=1
			potatoCount-=@cost
		else console.log("KAPPA")

	getMod: ->
		return @modifier
	isBuilt: ->
		return @built
	getName: ->
		return @name
	getNum: ->
		return @amount
upgradeInsert = (type, cost, modifier) ->
	console.log("HEEEEEY")
	built = false
	unless buildings.length == 0
		for i in buildings
			if i.getName == type
				i.purchase
				built = true
	if !built
		console.log("AYYYYYY")
		temp = new Building(type, cost, modifier)
		temp.purchase()



		