<template>
  <div>
    <p>Mandatory hours: {{
        `${schedule[0].getHours().toString().padStart(2, '0')}:${schedule[0].getMinutes().toString().padStart(2, '0')} - ${schedule[1].getHours().toString().padStart(2, '0')}:${schedule[1].getMinutes().toString().padStart(2, '0')}`
      }}</p>
    <p>Remaining paid overtime hours: {{ 5 - totalOvertime + "h"}}</p>
    <canvas ref="myChart"></canvas>
  </div>
</template>

<script setup>
import {Chart, registerables} from 'chart.js';
import {onMounted, ref} from 'vue';

/**
 * Plot the overtime hours, given an array of all concerned working hours and a fixed schedule.
 * Here is the format of the data which is expected in the prop:
 * workingHours: [{
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
 *     }]
 * schedule: {
 *     "id": 1,
 *     "type": "schedule",
 *     "start_time": "2024-10-16T09:00:00",
 *     "user_id": 1,
 *     "end_time": "2024-10-17T17:00:00"
 *     }
 */

Chart.register(...registerables);

const props = defineProps({
  workingHours: {
    type: Array,
    required: true
  },
  schedule: {
    type: Object,
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

function separateDateRanges(workingHours, schedule) {
  const insideSchedule = [];
  const outsideSchedule = [];

  const scheduleStart = new Date(schedule[0])
  const scheduleEnd = new Date(schedule[1])

  const scheduleStartSeconds = scheduleStart.getHours() * 3600 + scheduleStart.getMinutes() * 60 + scheduleStart.getSeconds()
  const scheduleEndSeconds = scheduleEnd.getHours() * 3600 + scheduleEnd.getMinutes() * 60 + scheduleEnd.getSeconds()

  workingHours.forEach(range => {
    const rangeStart = new Date(range[0]);
    const rangeEnd = new Date(range[1]);

    const rangeStartSeconds = rangeStart.getHours() * 3600 + rangeStart.getMinutes() * 60 + rangeStart.getSeconds()
    const rangeEndSeconds = rangeEnd.getHours() * 3600 + rangeEnd.getMinutes() * 60 + rangeEnd.getSeconds()
    // Case 1: Range is completely outside the schedule
    if (rangeEndSeconds < scheduleStartSeconds || rangeStartSeconds > scheduleEndSeconds) {
      outsideSchedule.push(range);
    }
    // Case 2: Range is completely inside the schedule
    else if (rangeStartSeconds >= scheduleStartSeconds && rangeEndSeconds <= scheduleEndSeconds) {
      insideSchedule.push(range);
    }
    // Case 3: Range overlaps with the schedule
    else {
      // If the start of the range is before the schedule starts
      if (rangeStartSeconds < scheduleStartSeconds) {
        outsideSchedule.push([rangeStart, scheduleStart]);
      }
      // If the end of the range is after the schedule ends
      if (rangeEndSeconds > scheduleEndSeconds) {
        outsideSchedule.push([scheduleEnd, rangeEnd]);
      }
      // The part that is inside the schedule
      insideSchedule.push([
        rangeStartSeconds > scheduleStartSeconds ? rangeStart : scheduleStart,
        rangeEndSeconds < scheduleEndSeconds ? rangeEnd : scheduleEnd
      ])
    }
  });
  return {dueHours: insideSchedule, overtimeHours: outsideSchedule}
}

const workingHours = subtractBreaksFromWork(
    props.workingHours
        .filter(e => e.type === "work")
        .map(e => [new Date(e.start_time), new Date(e.end_time)]),
    props.workingHours
        .filter(e => e.type === "break")
        .map(e => [new Date(e.start_time), new Date(e.end_time)]))
const schedule = [new Date(props.schedule.start_time), new Date(props.schedule.end_time)]
const overtimeHours = separateDateRanges(workingHours, schedule).overtimeHours
const totalOvertime = overtimeHours.reduce((acc, overtimeHour) => {
      const start = new Date(overtimeHour[0])
      const end = new Date(overtimeHour[1])
      const startSeconds = start.getHours() * 3600 + start.getMinutes() * 60 + start.getSeconds()
      const endSeconds = end.getHours() * 3600 + end.getMinutes() * 60 + end.getSeconds()

      return acc + (endSeconds - startSeconds) / 3600
    }, 0
)

const myChart = ref(null)
const chartData = {
  labels: ['Overtime'],
  datasets: [
    {
      label: ["Overtime"],
      data: [totalOvertime],
      backgroundColor: 'blue',
      borderColor: 'blue',
      borderWidth: 1,
      borderRadius: 10,
      barThickness: 20,
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
  indexAxis: "y",
  scales: {
    x: {
      min: 0,
      max: 5,
      title: {
        display: true,
        text: 'Overtime done',
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
        display: false
      },
      grid: {
        display: false,
        drawBorder: false
      }
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
  position: relative;
  width: 100%;
  height: 100px;
}
</style>
