import com.ibm.ws.tpv.engine.UserPreferences
import jarray
import sys

tpvName = AdminControl.completeObjectName("type=TivoliPerfEngine,*" )
tpvOName = AdminControl.makeObjectName(tpvName)

pref = com.ibm.ws.tpv.engine.UserPreferences()




pref.setServerName(sys.argv[1])

pref.setNodeName(sys.argv[3])

pref.setLogFileName(sys.argv[4])

pref.setUserId(sys.argv[2])

pref.setRefreshRate(int(sys.argv[5]))

pref.setBufferSize(int(sys.argv[6]))

pref.setNumLogFiles(int(sys.argv[7]))

pref.setLogFileSize(int(sys.argv[8]))

pref.setLoggingDuration(int(sys.argv[9]))

pref.setTpvLogFormat(sys.argv[10])


list_p = java.util.ArrayList()
list_p.add(pref)
params=jarray.array(list_p,java.lang.Object)


list_s = java.util.ArrayList()
list_s.add("com.ibm.ws.tpv.engine.UserPreferences")
sigs = jarray.array(list_s,java.lang.String)

#Start Monitoring Server#
AdminControl.invoke_jmx(tpvOName, "monitorServer", params, sigs )

#Logging Functionality#
AdminControl.invoke_jmx(tpvOName, sys.argv[11]+ "Logging", params, sigs )
