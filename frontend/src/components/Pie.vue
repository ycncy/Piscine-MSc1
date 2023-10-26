<template>
  <Pie
    id="my-chart-id"
    :options="chartOptions"
    :data="chartData"
  />
</template>

<script>
import {inject} from 'vue'
import { Pie } from 'vue-chartjs'
import {
  Chart as ChartJS,
  ArcElement,
  Tooltip,
  Legend
} from 'chart.js'

ChartJS.register(
  ArcElement,
  Tooltip,
  Legend
)

export default {
  name: 'LinrChart',
  components: { Pie },
  data() {
    return {
      chartData: {
        labels: inject('date'),
        datasets: inject('datasets')
      },
      chartOptions: {
        responsive: true
      }
    }
  }
}
</script>