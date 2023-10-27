<script setup>
import { ref } from 'vue';
import axios from 'axios';
import {useToast} from 'vue-toast-notification';
import 'vue-toast-notification/dist/theme-sugar.css';

const status = ref(false);
const sTime = ref(null);
const eTime = ref(null);
const timer = ref("00:00:00");

const route = window.location.href;
const id = route.split("/").slice(-1)[0];
let interval;

const fetchData = async () => {
  const resp = await axios.get(`http://localhost:4000/api/clocks/${id}`);
  status.value = resp.data.clock.status;
  if (status.value) {
    sTime.value = resp.data.clock.time;
    startTimer(new Date(resp.data.clock.time));
  }
};

const startTimer = (startTime) => {
  clearInterval(interval);
  interval = setInterval(() => {
    const now = new Date();
    const diff = new Date(now - startTime);
    const hh = String(diff.getUTCHours()).padStart(2, '0');
    const mm = String(diff.getUTCMinutes()).padStart(2, '0');
    const ss = String(diff.getUTCSeconds()).padStart(2, '0');
    timer.value = `${hh}:${mm}:${ss}`;
  }, 1000);
};

const clock = async () => {
  await axios.post(`http://localhost:4000/api/clocks/${id}?status=true`);
  fetchData();
};

const refresh = async () => {
  const $toast = useToast();
  $toast.success('WorkingTime Successfully Created!');
  clearInterval(interval);
  timer.value = '00:00:00';
  eTime.value = new Date().toISOString();
  await axios.post(`http://localhost:4000/api/clocks/${id}?status=false`);
  await axios.post(`http://localhost:4000/api/workingtimes/${id}?start=${sTime.value}&end=${sTime.value}`);
  fetchData();
};

fetchData();
</script>

<template>
  <div>
    <h1 class="mb-4 text-3xl font-extrabold text-gray-900 dark:text-white md:text-5xl lg:text-6xl"><span class="text-transparent bg-clip-text bg-gradient-to-r to-emerald-600 from-sky-400">The Clock</span></h1>
    <div class="w-full p-5 bg-white rounded-lg">
        <div class="flex flex-col items-center pb-10">
          <div class=" w-full shadow bg-neutral-800 rounded-lg p-6 mb-10">
            <h5 class="text-8xl font-bold text-gray-900 dark:text-white">{{ timer }}</h5>
          </div>
            <div class="flex mt-4 space-x-3 md:mt-6">
                <a v-if="status" @click="refresh" class=" scale-150 inline-flex items-center px-4 py-2 text-sm font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Stop Shift</a>
                <a v-else @click="clock" class=" scale-150 inline-flex items-center px-4 py-2 text-sm font-medium text-center text-gray-900 bg-white border border-gray-300 rounded-lg hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-700 dark:focus:ring-gray-700">Start Shift</a>
            </div>
        </div>
    </div>
</div>
</template>