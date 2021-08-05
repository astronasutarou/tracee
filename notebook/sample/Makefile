GEN := python generate_mock_data.py
KNN := python generate_knn-graph.py
TRA := python generate_tracklet.py

source = \
  mockdata_N006F030D000d00_b7e8.txt \
  mockdata_N006F030D000d50_b7e8.txt \
  mockdata_N006F030D500d00_b7e8.txt

knn_graph = $(patsubst %.txt,%.3nn.txt,$(source))
tracklet = $(patsubst %.txt,%.tra.txt,$(source))

.PHONY: mockdata

all: $(knn_graph) $(tracklet)


mockdata_N006F030D000d00_b7e8.txt:
	$(GEN) 6 30 0 --seed 47080

mockdata_N006F030D000d50_b7e8.txt:
	$(GEN) 6 30 0 --drop 0.5 --seed 47080

mockdata_N006F030D500d00_b7e8.txt:
	$(GEN) 6 30 500 --seed 47080

mockdata:
	for num in 5 10 25 50 100 125 150 ; do \
		$(GEN) $$num 30 200 -q --seed 5121; \
		$(GEN) $$num 30 200 -q --seed 5122; \
		$(GEN) $$num 30 200 -q --seed 5123; \
		$(GEN) $$num 30 200 -q --seed 5124; \
		$(GEN) $$num 30 200 -q --seed 5125; \
	done

%.3nn.txt: %.txt
	$(KNN) $< 3 $@

%.tra.txt: %.txt
	$(TRA) $< 3 $@

clean:
	rm -f *.txt
