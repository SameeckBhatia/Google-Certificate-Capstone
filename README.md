
## Google Certificate Capstone

### Prompt

"You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members." 

This capstone follows the six steps of the data analysis process.

---

### Ask

A clear statement of the business task.
  - Analyze usage patterns of Cyclistic bikes to develop a marketing strategy focused on converting casual riders to annual members.

### Prepare

A description of all data sources used.
  - The data has been gathered from Divvy Bikes' [system data](https://divvy-tripdata.s3.amazonaws.com/index.html).
  - Data originates from a collaboration between the City of Chicago and Lyft.

### Process

Documentation of any cleaning or manipulation of data.
  - Cleaned and merged data using [this script](Capstone%20Script.sql) in SQLite.
  - Filtered out null values for start and end station names in the data.
  - Created a temporary table for each analysis.

### Analyze

A summary of your analysis.
  - Identified trends in total ridership throughout the week, ridership in the past twelve months, and traffic from Cyclistic start stations.

### Share

Supporting visualizations and key findings.
  - Visualizations can be found in the [online presentation](https://tinyurl.com/cyclistic-slideshow) or on slides 4 to 6 in the respository's 'Slides' folder.
  - The findings include a drop in Sunday ridership due to preferences, members using the service significantly more in the winter, and casual riders accounting for a vast majority of trips to and from Navy Pier, a tourist attraction.

### Act

Your top three recommendations based on your analysis.
  - Promote routes/activities, and offer discounts to casual riders on weekends to increase Sunday ridership.
  - Create a referral program to reduce the ratio between member and casual riders for the winter months.
  - Increase marketing at the Street Dr & Grand Ave station to attract the high amount of casual riders.

---

#### Note: A link has been provided in the "About" section of this repository if you do not wish to download the HTML file.
