import sys
import jarray

server_name = sys.argv[0]
cell_name = sys.argv[1]
node_name = sys.argv[2]
dataSourceListObj = AdminConfig.list('DataSource', AdminConfig.getid( '/Cell:' + cell_name + '/Node:' + node_name + '/Server:' + server_name + '/')).splitlines()

for name in dataSourceListObj:
			try:
				data_source_name = name.replace("\"", "")
				index = data_source_name.index("(")
				data_source_name = data_source_name[0:index]
				test_datasource_connect = AdminControl.testConnection(name)
				isSuccess = test_datasource_connect.index("WASX7217I")
				print "data_source_connect_success:"+data_source_name
			except:
				print "data_source_connect_fail:"+data_source_name
				pass

			

			


			

			


