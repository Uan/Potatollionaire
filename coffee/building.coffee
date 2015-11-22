buildings = []
class Building
	constructor: (@name, @cost, @modifier) ->
		@built = false
		@amount = 0
	calculatePrice: ->
		console.log(@cost)
		if @amount > 0
			console.log("HAAAAAAAAAA")
			@cost = @cost*1.15
		return @cost
	purchase: ->	
		if potatoCount >= @calculatePrice()
			@built = true
			@amount+=1
			potatoCount-=@cost
		else console.log("Not enough resources?")

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
			if i.getName() == type
				i.purchase()
				built = true
	unless built
		console.log("AYYYYYY")
		temp = new Building(type, cost, modifier)
		buildings.push(temp)
		temp.purchase()



		