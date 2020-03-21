# Fetch up-to-date stock information about DeLorean parts

## Requirements

- bash
- curl
- jq

## Usage

```shell
./fetch-raw-data-eaglemoss.sh

# Optional argument: country selector
./fetch-raw-data-eaglemoss.sh uk
```

Produces `output-raw/` folder with the raw JSON stock data from each webshop.

```shell
./get-stock-eaglemoss.sh

# Optional argument: country selector
./get-stock-eaglemoss.sh uk
```

Produces `output-tsv/` folder with the available stock for each part, in tab-separated (TSV) format.

Prices are in local currency (GBP for UK, AUD for AU, EUR for the others.)

This format is ready to import to Google Spreadsheets / Microsoft Excel / etc.

## Example output

```shell
$ ./get-stock-eaglemoss.sh fr
DELFR001  Delorean de Retour vers le Futur - Étape 1  10.99 38  fr
DELFR002  Delorean de Retour vers le Futur - Étape 2  10.99 11  fr
DELFR003  Delorean de Retour vers le Futur - Étape 3  10.99 16  fr
DELFR004  Delorean de Retour vers le Futur - Étape 4  10.99 13  fr
DELFR005  Delorean de Retour vers le Futur - Étape 5  10.99 0 fr
DELFR006  Delorean de Retour vers le Futur - Étape 6  10.99 0 fr
DELFR007  Delorean de Retour vers le Futur - Étape 7  10.99 26  fr

[...]
```

ID|Title|Price|Stock left|Webshop country
-|-|-|-|-
DELFR001|Delorean de Retour vers le Futur - Étape 1|10.99|38|fr
DELUK003G|La Base da Esposizione DeLorean|59.99|96|it
