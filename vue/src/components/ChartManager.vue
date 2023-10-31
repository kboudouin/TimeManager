<script setup>
import { ref, onMounted, watch } from "vue";
import { Bar, Line } from "vue-chartjs";
import { useRoute } from "vue-router";
import axios from "axios";
import "chart.js/auto";

const dailyData = ref(null);
const weeklyData = ref(null);
const cumulativeData = ref(null);
const dateFilter = ref({ start: "2023-01-01", end: "2023-12-31" });
const chartOptions = ref();
const totalWorkedHours = ref(0);
const totalWorkedDays = ref(0);
const loading = ref(true);

const fetchData = async () => {
  loading.value = true;

  const route = useRoute();
  const id = route.params.id;
  const resp = await axios.get(
    `http://44.207.191.254:4000/api/workingtimes/${id}?start=${dateFilter.value.start}T00:00:00Z&end=${dateFilter.value.end}T00:00:00Z`
  );

  // Initialize containers for daily, weekly and Cumulative data
  const workByDay = {};
  const workByWeek = {};
  let cumulativeWorkHours = 0;
  const workByCumulative = [];

  if (resp.data && resp.data.workingtimes) {
    totalWorkedHours.value = 0;
    totalWorkedDays.value = 0;
    // Process the fetched data
    resp.data.workingtimes.forEach((wt) => {
      const day = getDayString(wt.start);
      const week = getWeekNumber(new Date(wt.start));
      const startHour = new Date(wt.start).getHours();
      const endHour = new Date(wt.end).getHours();
      const workHours = endHour - startHour;

      workByDay[day] = (workByDay[day] || 0) + workHours;
      workByWeek[week] = (workByWeek[week] || 0) + workHours;

      totalWorkedHours.value = Object.values(workByDay).reduce(
        (a, b) => a + b,
        0
      );
      totalWorkedDays.value = Object.keys(workByDay).length;
    });

    // Prepare the daily data
    dailyData.value = {
      labels: Object.keys(workByDay),
      datasets: [
        {
          label: "Daily Working Hours",
          data: Object.values(workByDay),
          backgroundColor: "#ed574c",
        },
      ],
    };

    // Prepare the weekly data
    weeklyData.value = {
      labels: Object.keys(workByWeek),
      datasets: [
        {
          label: "Weekly Working Hours",
          data: Object.values(workByWeek),
          backgroundColor: "#4caf50",
        },
      ],
    };

    // Prepare the comulative data

    Object.keys(workByDay)
      .sort()
      .forEach((day) => {
        cumulativeWorkHours += workByDay[day];
        workByCumulative.push({ day, cumulativeWorkHours });
      });

    cumulativeData.value = {
      labels: workByCumulative.map((d) => d.day),
      datasets: [
        {
          label: "Cumulative Work Hours",
          data: workByCumulative.map((d) => d.cumulativeWorkHours),
          borderColor: "#ffcc00",
        },
      ],
    };
  }
  loading.value = false;
};

watch(dateFilter, fetchData, { deep: true });
onMounted(fetchData);

const getDayString = (dateString) => {
  const date = new Date(dateString);
  return `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`;
};

const getWeekNumber = (date) => {
  const firstDayOfYear = new Date(date.getFullYear(), 0, 1);
  const pastDaysOfYear = (date - firstDayOfYear + 86400000) / 86400000;
  return `W-${Math.ceil((pastDaysOfYear + firstDayOfYear.getDay() + 1) / 7)}`;
};
</script>

<template>
  <!-- Date Filter + Stats -->
  <div class="p-4 bg-white rounded-lg mb-6 flex items-start">
    <span class="mr-4 text-black font-bold hidden">Filter by Date:</span>
    <input
      type="date"
      v-model="dateFilter.start"
      class="p-2 rounded font-bold w-full"
    />
    <span class="mx-4 text-black text-2xl font-extrabold">to</span>
    <input
      type="date"
      v-model="dateFilter.end"
      class="p-2 rounded font-bold w-full"
    />
  </div>
  <div class="p-4 bg-white rounded-lg mb-6 grid grid-rows-1 grid-flow-col">
    <div class="">
      <h2 class="text-black font-bold">Total Worked Hours</h2>
      <h2 class="text-xl text-black">{{ totalWorkedHours }}</h2>
    </div>
    <div class="">
      <h2 class="text-black font-bold">Total Work Days</h2>
      <h2 class="text-xl text-black">{{ totalWorkedDays }}</h2>
    </div>
  </div>

  <div v-if="loading">
    <div class="text-center mt-64 z-0">
      <div role="status">
        <svg
          aria-hidden="true"
          class="inline w-32 h-32 mr-42 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600"
          viewBox="0 0 100 101"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
            fill="currentColor"
          />
          <path
            d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
            fill="currentFill"
          />
        </svg>
        <span class="sr-only">Loading...</span>
      </div>
    </div>
  </div>

  <div class="grid grid-flow-row auto-rows-max items-center" v-else>
    <div>
      <!-- Daily Chart -->
      <div
        class="mt-4 bg-white p-4 rounded-lg h-25"
        v-if="dailyData"
        style="flex: 1"
      >
        <Bar id="Daily-Bar-Chart" :options="chartOptions" :data="dailyData" />
      </div>

      <!-- Weekly Chart -->
      <div
        class="mt-4 bg-white p-4 rounded-lg"
        v-if="weeklyData"
        style="flex: 1"
      >
        <bar id="Weekly-Bar-Chart" :options="chartOptions" :data="weeklyData" />
      </div>
    </div>

    <!-- Cummulative Chart -->
    <div
      class="mt-4 bg-white p-4 rounded-lg"
      v-if="cumulativeData"
      style="flex: 1"
    >
      <Line
        id="Cumulative-Line-Chart"
        :options="chartOptions"
        :data="cumulativeData"
      />
    </div>
  </div>
</template>
