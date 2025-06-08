Survival and Collapse of Historical States: Analysis Based on the MOROS Dataset

Objective

This project aims to analyze the formation, survival, and collapse patterns of historical states across ~5,000 years, drawing on the MOROS (Mortality of States) dataset as described in:

“Loss of Resilience in Aging Societies”
Proceedings of the National Academy of Sciences (PNAS), 2023
DOI: 10.1073/pnas.2218834120

The project explores questions such as:
	•	What is the typical lifespan of a state?
	•	How does collapse risk evolve as a state ages?
	•	How do geography and political type affect state survival?
	•	What are the common causes of state collapse?

Datasets

Table1.csv

Simplified export of the core variables from the MOROS dataset:
	•	Society_Polity: Name of the polity or state
	•	formation: State formation date (year)
	•	collapse: State collapse date (year)
	•	age: Lifespan of the polity (years)
	•	NaturalGeoArea: Geographic region
	•	quasi_polity: Boolean flag (True = quasi-state)

→ Ideal for reproducing PNAS paper analyses:
Kaplan-Meier survival curves, hazard functions, lifespan distributions.

⸻

Table2.csv

Extended dataset of 731 states/polities with additional detail:
	•	Formation, collapse, lifespan
	•	Political type and subtype
	•	Region, continent
	•	Collapse causes (Proximate_Cause, Underlying_Cause)
	•	Capital locations and coordinates
	•	Additional variables (e.g. violience_attractor)

→ Enables richer exploratory analysis:
	•	Political type comparison
	•	Geospatial mapping of state survival
	•	Analysis of collapse causes
	•	Temporal trends in state formation/collapse

⸻

Planned Analyses

1️⃣ Descriptive Analysis
	•	Distribution of state lifespans (age)
	•	Temporal trends in state formation/collapse
	•	Compare lifespans across political types and regions

2️⃣ Survival Analysis (core replication of PNAS)
	•	Kaplan-Meier survival curves
	•	Fit parametric hazard functions (lognormal, Gompertz, etc.)
	•	Compare survival probabilities by political type, geography

3️⃣ Geographic Visualization
	•	Map state capitals and visualize lifespan
	•	Analyze spatial patterns in state formation/collapse

4️⃣ Collapse Cause Analysis (Table2)
	•	Explore frequency of collapse causes
	•	Relate causes to political type, region, lifespan

5️⃣ Advanced Modeling
	•	Sensitivity of results to inclusion/exclusion of quasi-polities
	•	Time-windowed analysis (does average lifespan change over centuries?)
	•	Potential to explore loss of resilience trends as in the PNAS paper
Tools & Libraries

📊 Data processing & visualization
	•	pandas, numpy: data manipulation and analysis
	•	matplotlib, seaborn, plotly: data visualization
	•	geopandas, folium: geographic mapping and interactive maps (e.g. capitals)

📈 Survival analysis
	•	lifelines: Kaplan-Meier curves, hazard modeling, parametric survival models

🗺️ Geographic visualization
	•	folium: interactive maps (capital locations, regions, collapse hotspots)

🗂️ Text analysis & NLP
	•	wordcloud: generate word clouds from textual columns (Proximate_Cause, Underlying_Cause, Notes)
	•	nltk (Natural Language Toolkit): stopword removal, tokenization, lemmatization
	•	spacy: advanced NLP pipeline (lemmatization, named entity recognition if needed)
	•	sklearn.feature_extraction.text (TF-IDF Vectorizer): term frequency analysis
	•	gensim: topic modeling (LDA) — optional if you want to go deeper into text patterns
 
⸻

Deliverables
	•	Jupyter notebooks with full analysis
	•	Visualizations and charts
	•	Summary report of key findings
	•	This README
