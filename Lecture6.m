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


SUNDAY = data_2014(data_2014(1:365:7, :) == 1, 1:24);
MONDAY = data_2014(data_2014(2:365:7, :) == 2, 1:24);
TUESDAY = data_2014(data_2014(3:365:7, :) == 3, 1:24);
WEDNESDAY= data_2014(data_2014(4:365:7, :) == 4, 1:24);
THURSDAY = data_2014(data_2014(5:365:7, :) == 5, 1:24);
FRIDAY = data_2014(data_2014(6:365:7, :) == 6, 1:24);
SATURDAY = data_2014(data_2014(7:365:7, :) == 7, 1:24);
