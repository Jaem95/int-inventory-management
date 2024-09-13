%dw 2.0
@StreamCapable()
input payload application/csv
output application/json deferred=true, indent=false
---
flatten(payload)