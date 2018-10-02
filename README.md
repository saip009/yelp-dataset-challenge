# Yelp dataset challenge round 12

## Start Jupyter with Spark

- Download data from https://www.yelp.com/dataset/download.
- Unzip data in Data folder (in the root folder).
- To From the root folder run `docker-compose -f .\Docker\docker-compose.yml up`
- Open http://localhost:8888, and copy paste the access token in the prompt.
- Create your own notebook the notebooks folder to perform an analysis. This opens a jupyter notebook with an `sc` object available by default for the spark context.
- You can see the spark web ui at http://localhost:4040