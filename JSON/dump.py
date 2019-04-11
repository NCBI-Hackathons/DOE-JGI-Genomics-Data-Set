import requests
import json
import sys


def dump_query(data_request):
    # Get the first page and save it
    url = "http://sdm2.jgi-psf.org/api/metadata/pagequery"
    # data_request = '{"query":{"file_id":126293}}'
    data = requests.post(url, data=data_request).json()
    cursor_id = data['cursor_id']
    records = data['record_count']
    end = data['end']
    results = data['records']

    # Walk through the rest of the cursor
    url = "http://sdm2.jgi-psf.org/api/metadata/nextpage/%s" % cursor_id
    while end < records:
        data = requests.get(url).json()
        end = data['end']
        results.extend(data['records'])

    # Dump it to stdout
    return json.dumps(results[0], allow_nan=False)


control = sys.argv[1]
control = 'raw'
with open(control) as f:
    for line in f:
        file_name, field, id = line.rstrip().split('\t')
        with open("%s.json" % file_name, "w") as t:
            t.write(dump_query('{"query":{"%s":"%s"}}' % (field, id)))
