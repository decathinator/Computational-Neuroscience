
% CHECK THE FUNCTION TO MAKE SURE IT IS THE RIGHT NEURON (1 or 2) BEFORE
% YOU BEGIN RUNNING THIS

timeBins = [1, 40];
miValues = nan(size(timeBins));
[miValues(1)] = Assignment3_calculateMI_function(1);
[miValues(2)] = Assignment3_calculateMI_function(40);

bar(timeBins, miValues);
title('Mutual Information values for 1 and 40 millisecond timebins');
xlabel('Time Bins (milliseconds)');
ylabel('MI Values (bits)');


timeBins2 = [1, 2, 5, 10, 20, 40];
miValues2 = nan(size(timeBins2));
[miValues2(1)] = Assignment3_calculateMI_function(1);
[miValues2(2)] = Assignment3_calculateMI_function(2);
[miValues2(3)] = Assignment3_calculateMI_function(5);
[miValues2(4)] = Assignment3_calculateMI_function(10);
[miValues2(5)] = Assignment3_calculateMI_function(20);
[miValues2(6)] = Assignment3_calculateMI_function(40);

plot(timeBins2, miValues2, '-*');
title('Mutual Information Values for Various Timebins (Neuron 2)');
xlabel('Time Bins (milliseconds)');
ylabel('MI Values (bits)');



