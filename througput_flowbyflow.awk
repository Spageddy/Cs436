# This awk file calculates throughput, number of packets sent, received, and lost for every 0.5 time interval for each of the three flows

BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   timeInterval = 0.0;
   num_packets = 0;
   printf("Time \t Throughput \t Time Interval \t # of bytes \n")> "throughput_flowbyflow(8-11).xls";
   printf("Time \t Throughput \t Time Interval \t # of bytes \n")> "throughput_flowbyflow(8-16).xls";
   printf("Time \t Throughput \t Time Interval \t # of bytes \n")> "throughput_flowbyflow(9-12).xls";
   printf("Time \t Throughput \t Time Interval \t # of bytes \n")> "throughput_flowbyflow(9-17).xls";

}
{
  time2 = $2;

   timeInterval = time2 - time1;

   if ( timeInterval > 0.5) 
   {

      throughput_flow1 = bytes_counter_flow1 / timeInterval;
      # Export throughput of this time interval to xls file 
       printf("%f \t %f \t %f \t %f\n", time2, throughput_flow1, timeInterval, bytes_counter_flow1) > "throughput_flowbyflow(8-11).xls";
      bytes_counter_flow1 = 0;

      throughput_flow3 = bytes_counter_flow3 / timeInterval;
      # Export throughput of this time interval to xls file 
       printf("%f \t %f \t %f \t %f\n", time2, throughput_flow3, timeInterval, bytes_counter_flow3) > "throughput_flowbyflow(8-16).xls";
      bytes_counter_flow3 = 0;

      throughput_flow4 = bytes_counter_flow4 / timeInterval;
      # Export throughput of this time interval to xls file 
       printf("%f \t %f \t %f \t %f\n", time2, throughput_flow4, timeInterval, bytes_counter_flow4) > "throughput_flowbyflow(9-12).xls";
      bytes_counter_flow4 = 0;

      throughput_flow7 = bytes_counter_flow7 / timeInterval;
      # Export throughput of this time interval to xls file 
       printf("%f \t %f \t %f \t %f\n", time2, throughput_flow7, timeInterval, bytes_counter_flow7) > "throughput_flowbyflow(9-17).xls";
      bytes_counter_flow7 = 0;

      time1 = $2;
      }

 

   # if packet arrives at destination node 11 belongs to flow id 1
   if ($1 == "r" && $4 == 11 && $8 == 1) {
      bytes_counter_flow1 += $6;
      num_packets++;
   }

   # if packet arrives at destination node 16 belongs to flow id 3
   if ($1 == "r" && $4 == 16 && $8 == 3) {
      bytes_counter_flow3 += $6;
      num_packets++;
   }
   # if packet arrives at destination node 12 belongs to flow id 4
   if ($1 == "r" && $4 == 12 && $8 == 4) {
      bytes_counter_flow4 += $6;
      num_packets++;
   }
   # if packet arrives at destination node 17 belongs to flow id 7
   if ($1 == "r" && $4 == 17 && $8 == 7) {
      bytes_counter_flow7 += $6;
      num_packets++;
   }
}
END {
   print("********");
   printf("Total number of packets received: \n%d\n", num_packets);
   print("********");
}
