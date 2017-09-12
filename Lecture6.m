%Lecture 6

temps=csvread('tempdata.csv');
temps=temps(:,2);
%Read electricity demand data
data_2014 = csvread('hourly-day-ahead-bid-data-2014.csv',5,1);
vector = mat2vec(data_2014);
peak = zeros(365,1);

for i=1:365
    peak(i) = max(data_2014(i,:));
end

peak=peak/1000;

% forms 2-column matrix
combined = [temps peak];

% clusters for each row
IDX = kmeans(combined,3);

% forms 3-column matrix
clustered_data = [combined IDX];

% sorts 
sorted_data = sortrows(clustered_data,3);

% find indices of cluster 1
ONE = clustered_data(clustered_data(:,3)==1,1:2);

% find indices of cluster 2
TWO = clustered_data(clustered_data(:,3)==2,1:2);

% find indices of cluster 3
THREE = clustered_data(clustered_data(:,3)==3,1:2);

figure; 
hold on;
scatter(ONE(:,1),ONE(:,2),'r'); 
scatter(TWO(:,1),TWO(:,2) ,'b');
scatter(THREE(:,1),THREE(:,2) ,'g');
xlabel('Average Temperature (degrees F)','FontSize',14);
ylabel('Peak Electricity Demand (GWh)','FontSize',14);
legend('Cluster 1', 'Cluster 2', 'Cluster 3');
hold off;

%Timeseries data
January = mean(data_2014(1:31,:))
July = mean(data_2014 (182:212,:))
figure;
plot(January);
plot(July);


%Days-of-the-week
%January 1 - Wednesday (4)
%Sun - 1
%Mon - 2
%Tues - 3
%Wed - 4
%Thurs - 5
%Frid - 6
%Sat - 7

day = 4
calender = zeros(365,1);
for i = 1:365
    calender(i) = day;
    if day < 7
        day = day + 1;
    else
        day = 1;
    end
end

combined = [peak calender];
x  = sortrows(combined,2);

combined = [peak calender];
x  = sortrows(combined,2);
SUN = x(x(:, )==  ,1);
MON = x(x(:, )==  ,1);
TUE = x(x(:, )==  ,1);
WED = x(x(:, )==  ,1);
THU = x(x(:, )==  ,1);
FRI = x(x(:, )==  ,1);
SAT = x(x(:, )==  ,1);
