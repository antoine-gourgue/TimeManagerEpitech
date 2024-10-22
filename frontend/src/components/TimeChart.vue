<template>
  <div>
    <canvas ref="myChart"></canvas>
  </div>
</template>

<script setup>
import {Chart, registerables} from 'chart.js';
import {onMounted, ref} from 'vue';

/**
 * Plot the workings hours of an employee in a bar chart, also representing the rest times
 * Here is the format of the data which is expected in the prop:
 * [
 *   {
 *     "id": 1,
 *   "type": "work",
 *   "start_time": "2024-10-14T09:00:00",
 *   "user_id": 1,
 *   "end_time": "2024-10-14T23:00:00"
 *   },
 *   {
 *   "id": 2,
 *   "type": "break",
 *   "start_time": "2024-10-14T12:00:00",
 *   "user_id": 1,
 *   "end_time": "2024-10-14T12:30:00"
 *   }
 * ]
 */
Chart.register(...registerables);

const props = defineProps({
  workingHours: {
    type: Array,
    required: true
  }
})

function subtractBreaksFromWork(workingHours, restHours) {
  const adjustedWorkingHours = []
  for (const [workStart, workEnd] of workingHours) {
    let currentStart = workStart
    let currentEnd = workEnd

    for (const [restStart, restEnd] of restHours) {
      if (restEnd <= currentStart || restStart >= currentEnd) {
        continue
      }
      if (restStart > currentStart) {
        adjustedWorkingHours.push([currentStart, restStart])
      }
      currentStart = new Date(Math.max(currentStart, restEnd))
    }
    if (currentStart < currentEnd) {
      adjustedWorkingHours.push([currentStart, currentEnd])
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

      workingHoursByDay.get(startDateStr).push([workingTime[0], startTimeFirstDay])
      workingHoursByDay.get(endDateStr).push([new Date(endDateStr), workingTime[1]])
    } else {
      workingHoursByDay.get(startDateStr).push(workingTime)
    }
  }
  return workingHoursByDay
}

function fillLeadingAndTrailingHours(workingHoursByDay) {
// add leading and trailing time span to match a [0h:24h] period
  for (const [date, workingHours] of workingHoursByDay) {
    const dayStart = new Date(date+"T00:00:00")
    const dayEnd = new Date(date+"T23:59:59")

    let newWorkingHours = [[dayStart, workingHours[0][0]]]
    for (let i = 0; i < workingHours.length - 1; ++i) {
      newWorkingHours.push(workingHours[i])
      newWorkingHours.push([workingHours[i][1], workingHours[i + 1][0]])
    }
    newWorkingHours.push(workingHours[workingHours.length - 1])
    newWorkingHours.push([workingHours[workingHours.length - 1][1], dayEnd])
    workingHoursByDay.set(date, newWorkingHours)
  }
  return workingHoursByDay
}

function computeDurations(workingHoursByDayFilled) {
  /**
   * Returns a 2 dimensional array that follows this syntax :
   * [[day1Duration1, day2Duration1, ...]
   * [day1Duration2, day2Duration2,...]
   * [day1Duration3, day3Duration3,...]
   * ...
   * ]
   */
  let durations = []
  for (let i = 0; i < 10; ++i) {
    let days = Array.from(workingHoursByDayFilled.keys())
    durations.push(days.map(date => {
      if (i >= workingHoursByDayFilled.get(date).length) {
        return 0
      } else {
        return (workingHoursByDayFilled.get(date)[i][1] - workingHoursByDayFilled.get(date)[i][0]) / 1000 / 3600 // convert from ms to h
      }
    }))
  }
  return durations
}

function generatePlots(durations) {
  const plots = []
  for (let i = 0; i < workingHours.length / 2 + 2; ++i) {
    plots.push({
      data: durations[2 * i],
      backgroundColor: 'grey',
      borderColor: 'grey',
      borderWidth: 1,
    })
    plots.push({
      data: durations[2 * i + 1],
      backgroundColor: 'blue',
      borderColor: 'blue',
      borderWidth: 1,
    },)
  }
  plots.push({
    data: durations[durations.length - 1],
    backgroundColor: 'grey',
    borderColor: 'grey',
    borderWidth: 1,
  })
  return plots
}

const workingHours = subtractBreaksFromWork(
    props.workingHours
        .filter(e => e.type === "work")
        .map(e => [new Date(e.start_time), new Date(e.end_time)]),
    props.workingHours
        .filter(e => e.type === "break")
        .map(e => [new Date(e.start_time), new Date(e.end_time)]))
    .sort((starTime1, startTime2) => starTime1[0] - startTime2[0]) // ascending start date sort
const workingHoursByDay = categorizeByDate(workingHours)
const workingHoursByDayFilled = fillLeadingAndTrailingHours(workingHoursByDay)
const durations = computeDurations(workingHoursByDayFilled)
const plots = generatePlots(durations)

const myChart = ref(null)
const chartData = {
  labels: Array.from(workingHoursByDayFilled.keys()),
  datasets: plots,
}
const chartOptions = {
  responsive: true,
  plugins: {
    legend: {
      display: false
    }
  },
  indexAxis: "y",
  scales: {
    x: {
      stacked: true,
      min: 0,
      max: 24,
      ticks: {
        callback: function(value) {
          return value + 'h'; // Format ticks to show hours
        }
      }
    },
    y: {
      stacked: true,
    },
  },
}

onMounted(() => {
  const ctx = myChart.value.getContext('2d');
  new Chart(ctx, {
    type: 'bar',
    data: chartData,
    options: chartOptions,
  });
});
</script>

<style scoped>
canvas {
  width: 1000px;
  //max-width: 600px;
}
</style>
