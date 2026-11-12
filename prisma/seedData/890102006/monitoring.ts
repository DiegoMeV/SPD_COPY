export const monitoringConfig = [
    {
        "devPlanCode": "2",
        "isActive": true,
        "period": 2022,
        "subperiod": 3,
        "periodicity": 3,
        "spentDoc": ["COMMITMENT", "OBLIGATION"],
        "weightingType": "FINANCIAL",
        "datesConfig": {
            "reporting": [
                "2022-10-10T03:00:02.879Z",
                "2022-10-12T03:00:02.879Z"
            ],
            "reviewing": [
                "2022-10-01T03:00:02.879Z",
                "2022-10-24T03:00:02.879Z"
            ],
            "scheduling": [
                "2022-10-01T03:00:02.879Z",
                "2022-10-09T03:00:02.879Z"
            ],
            "validating": [
                "2022-10-10T03:00:02.879Z",
                "2022-10-17T03:00:02.879Z"
            ]
        },
        "colorsConfig": [
            {
                "color": "#eb4334",
                "toValue": 50,
                "fromValue": 0,
                "includeToValue": true,
                "includeFromValue": true
            },
            {
                "color": "#ebe534",
                "toValue": 85,
                "fromValue": 50,
                "includeToValue": true,
                "includeFromValue": false
            },
            {
                "color": "#4ead58",
                "toValue": 100,
                "fromValue": 85,
                "includeToValue": true,
                "includeFromValue": false
            }
        ],
        "status": "CREATED",
        "statusDates": [
            "2022-10-20T00:02:25.718Z"
        ],
        "monitoringGoalTypeConfig": [
            {
                "id": 1,
                "createdAt": "2022-10-24T20:38:55.701Z",
                "updatedAt": "2022-10-24T20:38:55.701Z",
                "monitoringConfigId": 6,
                "goalType": "RESULT",
                "devPlanLevel": 2
            },
            {
                "id": 2,
                "createdAt": "2022-10-24T20:39:03.824Z",
                "updatedAt": "2022-10-24T20:39:03.824Z",
                "monitoringConfigId": 6,
                "goalType": "PRODUCT",
                "devPlanLevel": 3
            }
        ]
    }
];