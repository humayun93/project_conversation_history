
# Questions

1. Should the application be for the web only?
- Answer: We should consider extending the application to mobile as well.   

#### Decision: Make the api applicaiton

2. Should the users have ability to leave replies to comments in project?
- Answer: yes
####  Decision: Add ability to leave replies to 1 level

3. Should we have consider ability to extend the API with new features?
- Answer: yes

4. Should we consider API interaction performance? 
- Answer: yes

5. Should we consider API first design without deciding prior handshakes between API and FE/ mobile?
- Answer: yes

#### Decision: Use GraphQL to allow extending, higher performance in queries with flexible requests to fetch only required data. 
