class_name ResourceTotal

static var zero_data = {
	"housing": 0,
	"food" : 0,
	"water" : 0,
	"power" : 0,
	"waste_management" : 0
	}
	
var data = zero_data
	
func init():
	pass

func add(resource_total : ResourceTotal):
	for key in resource_total.data.keys():
		data[key] += resource_total.data[key]
