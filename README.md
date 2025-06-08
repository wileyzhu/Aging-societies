# Survival and Collapse of Historical States: Analysis Based on the MOROS Dataset

## Objective

This project analyzes the formation, survival, and collapse patterns of historical states across ~5,000 years, using the **MOROS (Mortality of States)** dataset as described in:

> *Loss of Resilience in Aging Societies*, Proceedings of the National Academy of Sciences (PNAS), 2023  
> DOI: [10.1073/pnas.2218834120](https://doi.org/10.1073/pnas.2218834120)

The project explores questions such as:

- What is the typical lifespan of a state?
- How does collapse risk evolve as a state ages?
- How do geography and political type affect state survival?
- What are common causes of state collapse?
- Can we detect patterns in textual descriptions of collapse?

---

## Datasets

### `Table1.csv`

A simplified export of the core variables from the **MOROS** dataset:

| Column          | Description                              |
|-----------------|------------------------------------------|
| `Society_Polity` | Name of the polity or state               |
| `formation`      | State formation date (year)               |
| `collapse`       | State collapse date (year)                |
| `age`            | Lifespan of the polity (years)            |
| `NaturalGeoArea` | Broad geographic area of the polity       |
| `quasi_polity`   | Boolean flag — quasi-state or full state  |

→ Ideal for reproducing the **PNAS paper analysis**:
- Kaplan-Meier survival curves
- Hazard functions
- Lifespan distributions

---

### `Table2.csv`

An extended dataset of **731 states/polities** with additional variables:

| Column                   | Example Fields |
|--------------------------|----------------|
| Formation, collapse, lifespan | `State_Formation_low`, `Collapse_high`, `age` |
| Political type, subtype       | `Political_Type`, `Political_Sub_Type` |
| Geography                    | `Region`, `continent`, `Capital`, lat/lon |
| Collapse causes              | `Proximate_Cause`, `Underlying_Cause` |
| Notes, text data             | `Notes`, `Relatationship` |
| Others                       | `violience_attractor`, `censored` |

→ Enables richer exploratory analysis:
- Political type comparison
- Mapping of state locations and survival
- Analysis of textual collapse causes
- Advanced temporal patterns

---

## Planned Analyses

### 1️⃣ Descriptive Analysis

- Distribution of state lifespans (`age`)
- Trends in state formation and collapse over time
- Comparison of lifespans across political types and regions

### 2️⃣ Survival Analysis

- Kaplan-Meier survival curves
- Parametric hazard models (lognormal, Gompertz, etc.)
- Comparison of survival probability by political type and region

### 3️⃣ Geographic Visualization

- Mapping of state capitals and lifespan using `folium`
- Spatial patterns of state formation and collapse

### 4️⃣ Collapse Cause Analysis (Table2)

- Frequency analysis of `Proximate_Cause`, `Underlying_Cause`
- Text analysis of `Notes` and cause columns
- Potential topic modeling (LDA)

### 5️⃣ Advanced Modeling

- Impact of including/excluding quasi-polities
- Trends in average lifespan over historical periods
- Replication and extension of the **PNAS "Loss of Resilience"** findings

---

## Tools & Libraries

### 📊 Data Processing & Visualization

- `pandas`, `numpy`: Data manipulation and analysis
- `matplotlib`, `seaborn`, `plotly`: Visualizations

### 📈 Survival Analysis

- `lifelines`: Kaplan-Meier curves, hazard modeling

### 🗺️ Geographic Visualization

- `geopandas`, `folium`: Interactive geographic maps (state capitals, collapse hotspots)

### 🗂️ Text Analysis & NLP

- `wordcloud`: Generate word clouds of textual columns
- `nltk`: Tokenization, stopword removal, lemmatization
- `spacy`: Advanced NLP (lemmatization, NER if needed)
- `sklearn.feature_extraction.text` (TF-IDF Vectorizer): Term frequency analysis
- `gensim`: Topic modeling (LDA)

---

## Deliverables

- Jupyter notebooks with full analysis
- Visualizations and maps
- Summary report of key findings
- `README.md`

---

## Notes

- The project is inspired by the **MOROS** dataset described in the PNAS paper, and uses both core variables (`Table1.csv`) and extended variables (`Table2.csv`) to explore survival dynamics of historical states.
- Additional exploratory text analysis is performed to extract patterns from collapse causes and narrative descriptions.

---
