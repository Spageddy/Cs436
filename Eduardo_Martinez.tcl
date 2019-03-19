#Create a simulator object
set ns [new Simulator]

#Tell the simulator to use dynamic routing
$ns rtproto DV

#Create a trace file
set tracefd [open Eduardo_Martinez.tr w]
$ns trace-all $tracefd

#Define a 'finish' procedure
proc finish {} {
	global ns nf
	$ns flush-trace
	#Close the trace file
	#close $nf
	exit 0
}

#Create 17 nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]
set n11 [$ns node]
set n12 [$ns node]
set n13 [$ns node]
set n14 [$ns node]
set n15 [$ns node]
set n16 [$ns node]
set n17 [$ns node]

#Create a duplex link between the nodes
$ns duplex-link $n2 $n3 8Mb 100ms DropTail
$ns duplex-link $n2 $n4 8Mb 100ms DropTail
$ns duplex-link $n3 $n4 8Mb 100ms DropTail

#Set Queue Size of links to 30^M
$ns queue-limit $n2 $n3 30^M
$ns queue-limit $n2 $n4 30^M
$ns queue-limit $n3 $n4 30^M

#Create a duplex link between the nodes
$ns duplex-link $n0 $n2 2Mb 40ms DropTail
$ns duplex-link $n1 $n2 2Mb 40ms DropTail
$ns duplex-link $n5 $n3 2Mb 40ms DropTail
$ns duplex-link $n6 $n4 2Mb 40ms DropTail
$ns duplex-link $n7 $n4 2Mb 40ms DropTail

#Set Queue Size of links to 25^M
$ns queue-limit $n0 $n2 25^M
$ns queue-limit $n1 $n2 25^M
$ns queue-limit $n5 $n3 25^M
$ns queue-limit $n6 $n4 25^M
$ns queue-limit $n7 $n4 25^M

#Create a duplex link between the nodes
$ns duplex-link $n8 $n0 1Mb 20ms DropTail
$ns duplex-link $n9 $n1 1Mb 20ms DropTail
$ns duplex-link $n10 $n5 1Mb 20ms DropTail
$ns duplex-link $n11 $n5 1Mb 20ms DropTail
$ns duplex-link $n12 $n5 1Mb 20ms DropTail
$ns duplex-link $n13 $n5 1Mb 20ms DropTail
$ns duplex-link $n14 $n6 1Mb 20ms DropTail
$ns duplex-link $n15 $n6 1Mb 20ms DropTail
$ns duplex-link $n16 $n7 1Mb 20ms DropTail
$ns duplex-link $n17 $n7 1Mb 20ms DropTail

#Set Queue Size of links to 20^M
$ns queue-limit $n8 $n0 20^M
$ns queue-limit $n9 $n1 20^M
$ns queue-limit $n10 $n5 20^M
$ns queue-limit $n11 $n5 20^M
$ns queue-limit $n12 $n5 20^M
$ns queue-limit $n13 $n5 20^M
$ns queue-limit $n14 $n6 20^M
$ns queue-limit $n15 $n6 20^M
$ns queue-limit $n16 $n7 20^M
$ns queue-limit $n17 $n7 20^M

#Create a UDP agent for each traffic source and attach it to node n0
set udp0 [new Agent/UDP]
set udp1 [new Agent/UDP]
set udp2 [new Agent/UDP]
set udp3 [new Agent/UDP]
$ns attach-agent $n9 $udp0
$ns attach-agent $n9 $udp1
$ns attach-agent $n9 $udp2
$ns attach-agent $n9 $udp3

#Set flow id for each traffic
$udp0 set fid_ 4
$udp1 set fid_ 5
$udp2 set fid_ 6
$udp3 set fid_ 7

# Create a CBR generator for each traffic source and attach it to its udp agent
set cbr4 [new Application/Traffic/CBR]
$cbr4 set packetSize_ 1000
$cbr4 set interval_ 0.005
$cbr4 set random_ 1
$cbr4 attach-agent $udp0

set cbr5 [new Application/Traffic/CBR]
$cbr5 set packetSize_ 3000
$cbr5 set interval_ 0.005
$cbr5 set random_ 1
$cbr5 attach-agent $udp1

set cbr6 [new Application/Traffic/CBR]
$cbr6 set packetSize_ 2000
$cbr6 set interval_ 0.005
$cbr6 set random_ 1
$cbr6 attach-agent $udp2

set cbr7 [new Application/Traffic/CBR]
$cbr7 set packetSize_ 2000
$cbr7 set interval_ 0.005
$cbr7 set random_ 1
$cbr7 attach-agent $udp3

#Create a LossMonitor agent (a traffic sink) for each traffic and attach it to 
#node 12,13,15,17
set sink4 [new Agent/LossMonitor]
set sink5 [new Agent/LossMonitor]
set sink6 [new Agent/LossMonitor]
set sink7 [new Agent/LossMonitor]
$ns attach-agent $n12 $sink4
$ns attach-agent $n13 $sink5
$ns attach-agent $n15 $sink6
$ns attach-agent $n17 $sink7

#Connect the traffic sources to the traffic sinks
$ns connect $udp0 $sink4
$ns connect $udp1 $sink5
$ns connect $udp2 $sink6
$ns connect $udp3 $sink7

#Setup a TCP connection
set tcp0 [new Agent/TCP]
$tcp0 set class_ 2
$ns attach-agent $n8 $tcp0

set tcp1 [new Agent/TCP]
$tcp1 set class_ 2
$ns attach-agent $n8 $tcp1

set tcp2 [new Agent/TCP]
$tcp2 set class_ 2
$ns attach-agent $n8 $tcp2

set tcp3 [new Agent/TCP]
$tcp3 set class_ 2
$ns attach-agent $n8 $tcp3

#Set flow id for each traffic
$tcp0 set fid_ 0
$tcp1 set fid_ 1
$tcp2 set fid_ 2
$tcp3 set fid_ 3

# Create a CBR generator for each traffic source and attach it to its udp agent
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 1000
$cbr0 set interval_ 0.005
$cbr0 set random_ 1
$cbr0 attach-agent $tcp0

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 3000
$cbr1 set interval_ 0.005
$cbr1 set random_ 1
$cbr1 attach-agent $tcp1

set cbr2 [new Application/Traffic/CBR]
$cbr2 set packetSize_ 2000
$cbr2 set interval_ 0.005
$cbr2 set random_ 1
$cbr2 attach-agent $tcp2

set cbr3 [new Application/Traffic/CBR]
$cbr3 set packetSize_ 2000
$cbr3 set interval_ 0.005
$cbr3 set random_ 1
$cbr3 attach-agent $tcp3


#Setup a TCP Sink connection
set sink0 [new Agent/TCPSink]
$ns attach-agent $n10 $sink0
$ns connect $tcp0 $sink0

set sink1 [new Agent/TCPSink]
$ns attach-agent $n11 $sink1
$ns connect $tcp1 $sink1

set sink2 [new Agent/TCPSink]
$ns attach-agent $n14 $sink2
$ns connect $tcp2 $sink2

set sink3 [new Agent/TCPSink]
$ns attach-agent $n16 $sink3
$ns connect $tcp3 $sink3

#Schedule events for the CBR agent and the network dynamics
$ns at 0.5 "$cbr0 start"
$ns at 0.5 "$cbr1 start"
$ns at 0.5 "$cbr2 start"
$ns at 0.5 "$cbr3 start"
$ns at 1.0 "$cbr4 start"
$ns at 1.0 "$cbr5 start"
$ns at 1.0 "$cbr6 start"
$ns at 1.0 "$cbr7 start"
$ns rtmodel-at 3.0 down $n2 $n3
$ns rtmodel-at 3.5 up $n2 $n3
$ns at 5.0 "$cbr0 stop"
$ns at 5.0 "$cbr1 stop"
$ns at 5.0 "$cbr2 stop"
$ns at 5.0 "$cbr3 stop"
$ns at 5.0 "$cbr4 stop"
$ns at 5.0 "$cbr5 stop"
$ns at 5.0 "$cbr6 stop"
$ns at 5.0 "$cbr7 stop"
#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

#Run the simulation
$ns run