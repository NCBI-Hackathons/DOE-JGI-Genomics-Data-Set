import json

with open('combined_records.json') as json_file:
    data = json.load(json_file)

output = []
for record in data:
    term = record['term']
    field = record['field']
    for var in record['envo']:
        envo = []
        for t in var['coverageResult']['annotations']:
            envo.append(t['annotatedClass']['@id'])
        output.append({'term': term, 'field': field, 'envo': envo})

with open("combined_stripped_data.json", 'w') as f:
    f.write(json.dumps(output))
