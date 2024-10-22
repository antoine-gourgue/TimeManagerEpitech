<template>
  <div>
    <canvas ref="myChart"></canvas>
  </div>
</template>

<script setup>
import {Chart, registerables} from 'chart.js';
import {onMounted, ref} from 'vue';

/**
 * Plot the average working time worked by all the users which actually worded on that day.
 * Example of expected input data:
 * [{
 *     "id": 1,
 *     "type": "work",
 *     "start_time": "2024-10-14T10:00:00",
 *     "user_id": 1,
 *     "end_time": "2024-10-14T16:00:00"
 *     },
 *     {
 *     "id": 2,
 *     "type": "break",
 *     "start_time": "2024-10-14T12:00:00",
 *     "user_id": 1,
 *     "end_time": "2024-10-14T12:30:00"
 *     },
 *     {
 *     "id": 1,
 *     "type": "work",
 *     "start_time": "2024-10-15T16:00:00",
 *     "user_id": 1,
 *     "end_time": "2024-10-15T20:00:00"
 *     }
 * ]
 */

Chart.register(...registerables);

const props = defineProps({
  workingHours: {
    type: Array,
    required: true
  },
})

function subtractBreaksFromWork(workingHours, restHours) {
  const adjustedWorkingHours = []
  for (const [workStart, workEnd, userId] of workingHours) {
    let currentStart = workStart
    let currentEnd = workEnd

    for (const [restStart, restEnd, restUserId] of restHours) {
      if (userId !== restUserId) {
        continue
      }
      if (restEnd <= currentStart || restStart >= currentEnd) {
        continue
      }
      if (restStart > currentStart) {
        adjustedWorkingHours.push([currentStart, restStart, userId])
      }
      currentStart = new Date(Math.max(currentStart, restEnd))
    }
    if (currentStart < currentEnd) {
      adjustedWorkingHours.push([currentStart, currentEnd, userId])
    }
  }

  return adjustedWorkingHours;
}

function categorizeByDate(workingHours) {
  const workingHoursByDay = new Map()
  for (let i = 0; i < workingHours.length; ++i) {
    const workingTime = workingHours[i]
    const startDateStr = workingTime[0].toISOString().split('T')[0]
    const endDateStr = workingTime[1].toISOString().split('T')[0]
    if (!workingHoursByDay.has(startDateStr)) {
      workingHoursByDay.set(startDateStr, [])
    }
    if (!workingHoursByDay.has(endDateStr)) {
      workingHoursByDay.set(endDateStr, [])
    }
    if (new Date(startDateStr).getTime() !== new Date(endDateStr).getTime()) {
      let startTimeFirstDay = new Date(startDateStr)
      startTimeFirstDay.setHours(23)
      startTimeFirstDay.setMinutes(59)
      startTimeFirstDay.setSeconds(59)

      workingHoursByDay.get(startDateStr).push([workingTime[0], startTimeFirstDay, workingTime[2]])
      workingHoursByDay.get(endDateStr).push([new Date(endDateStr), workingTime[1], workingTime[2]])
    } else {
      workingHoursByDay.get(startDateStr).push(workingTime)
    }
  }
  return workingHoursByDay
}

function computeAvgWorkingTimeByDay(workingHoursByDay) {
  const avgTimesByDay = new Map()
  for (const [date, workingHours] of workingHoursByDay) {
    const usersNumber = new Set(workingHours.map(workingHour => workingHour.user_id)).size
    avgTimesByDay.set(
        date,
        workingHours.reduce(
            (acc, workingHour) => acc + (workingHour[1].getTime() - workingHour[0].getTime()) / 1000 / 3600, 0) / usersNumber
    ) // get mean working time in hours
  }
  return avgTimesByDay
}

const workingHours = subtractBreaksFromWork(
    props.workingHours
        .filter(e => e.type === "work")
        .map(e => [new Date(e.start_time), new Date(e.end_time), e.user_id]),
    props.workingHours
        .filter(e => e.type === "break")
        .map(e => [new Date(e.start_time), new Date(e.end_time), e.user_id]))
const workingHoursByDay = categorizeByDate(workingHours)
const avgWorkingTimePerDay = computeAvgWorkingTimeByDay(workingHoursByDay)

const myChart = ref(null)
const chartData = {
  labels: Array.from(avgWorkingTimePerDay.keys()),
  datasets: [
    {
      data: Array.from(avgWorkingTimePerDay.values()),
      backgroundColor: 'blue',
      borderColor: 'blue',
    },
  ],
}
const chartOptions = {
  responsive: true,
  plugins: {
    legend: {
      display: false
    }
  },
  scales: {
    x: {
      title: {
        display: false
      },
      grid: {
        display: false,
        drawBorder: false
      },
      ticks: {
        display: true
      }
    },
    y: {
      beginAtZero: true,
      ticks: {
        display: true
      },
    },
  },
}

onMounted(() => {
  const ctx = myChart.value.getContext('2d');
  new Chart(ctx, {
    type: 'line',
    data: chartData,
    options: chartOptions
  });
});
</script>

<style scoped>
canvas {
  position: relative;
  width: 100%;
  height: 300px;
}
</style>
