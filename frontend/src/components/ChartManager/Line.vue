<script>
import {Line} from 'vue-chartjs'
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
} from 'chart.js'
import {list} from "postcss";
import {data} from "autoprefixer";

ChartJS.register(
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    Title,
    Tooltip,
    Legend
)

export default {
  name: 'LinrChart',
  computed: {
    data() {
      return data
    }
  },
  components: {Line},
  props: {
    dataset: list,
    date: list
  },
  data() {
    return {
      chartOptions: {
        responsive: true,
        plugins: {
          title: {
            display: true,
            text: 'Working times line chart'
          },
        }
      }
    }
  },
}
</script>

<template>
  <Line
      id="my-chart-id"
      :options="chartOptions"
      :data="{
      labels: date,
      datasets: dataset
    }"
  />
</template>