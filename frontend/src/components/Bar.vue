<template>
  <Bar
    id="my-chart-id"
    :options="chartOptions"
    :data="chartData"
  />
</template>

<script>
import {inject} from 'vue'
import { Bar } from 'vue-chartjs'
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  BarElement,
  Title,
  Tooltip,
  Legend
} from 'chart.js'

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  BarElement,
  Title,
  Tooltip,
  Legend
)

export default {
  name: 'LinrChart',
  components: { Bar },
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