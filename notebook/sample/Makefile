GEN := python generate_mock_data.py
KNN := python generate_knn-graph.py
TRA := python generate_tracklet.py

source = \
  mockdata_N006F030D000d00_b7e8.txt \
  mockdata_N006F030D000d50_b7e8.txt \
  mockdata_N006F030D100d00_b7e8.txt \
  mockdata_N006F030D500d00_b7e8.txt \
  mockdata_N006F030D500d30_b7e8.txt \
  mockdata_N050F030D000d00_ad65.txt

knn_graph = $(patsubst %.txt,%.3nn.txt,$(source))
tracklet = $(patsubst %.txt,%.tra.txt,$(source))

all: $(knn_graph) $(tracklet)


mockdata_N006F030D000d00_b7e8.txt:
	$(GEN) 6 30 0 --seed 47080

mockdata_N006F030D000d50_b7e8.txt:
	$(GEN) 6 30 0 --drop 0.5 --seed 47080

mockdata_N006F030D100d00_b7e8.txt:
	$(GEN) 6 30 100 --seed 47080

mockdata_N006F030D500d00_b7e8.txt:
	$(GEN) 6 30 500 --seed 47080

mockdata_N006F030D500d30_b7e8.txt:
	$(GEN) 6 30 500 --drop 0.3 --seed 47080

mockdata_N050F030D000d00_ad65.txt:
	$(GEN) 50 30 0 --seed 44389

%.3nn.txt: %.txt
	$(KNN) $< 3 $@

%.tra.txt: %.txt
	$(TRA) $< 3 $@
