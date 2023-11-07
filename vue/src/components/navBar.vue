<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";
import { useRouter, useRoute } from "vue-router";
import { useToast } from "vue-toast-notification";
import "vue-toast-notification/dist/theme-sugar.css";
import VueCookies from "vue-cookies";
import router from "../router";
import { defineEmits } from "vue";

const emit = defineEmits(["userConnected"]);
const showSideNav = ref(false);
const isAdmin = ref(false);

const checkAdmin = () => {
  isAdmin.value = localStorage.getItem("role") === "admin";
};

const toggleSideNav = () => {
  showSideNav.value = !showSideNav.value;
};

onMounted(checkAdmin);
</script>

<template>
  <!-- MENU -->
  <div class="">
    <button
      class="p-4 m-2 bg-blue-800"
      @click="toggleSideNav"
      style="position: fixed; z-index: 100; top: 0px; left: 0px"
    >
      ☰
    </button>

    <div
      class="flex flex-col flex-auto flex-shrink-0 antialiased bg-gray-50 text-gray-800 md:block z-50"
      v-show="showSideNav"
    >
      <div
        class="fixed flex flex-col top-0 left-0 w-72 bg-white h-full border-r"
        style="z-index: 90"
      >
        <div class="flex items-center justify-center h-14 border-b ml-12 mt-3">
          <h1 class="flex items-center text-xl font-extrabold">
            TimeManager<span
              class="bg-blue-100 text-blue-800 text-xl font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-blue-200 dark:text-blue-800 ml-2"
              >PRO</span
            >
          </h1>
        </div>
        <div class="overflow-y-auto overflow-x-hidden flex-grow">
          <ul class="flex flex-col py-4 space-y-1">
            <li class="px-5">
              <div class="flex flex-row items-center h-8">
                <div class="text-sm font-light tracking-wide text-gray-500">
                  Menu
                </div>
              </div>
            </li>
            <li>
              <a
                @click="Dashboard"
                href="#"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
                    ></path>
                  </svg>
                </span>
                <span
                  @click="Dashboard"
                  class="ml-2 text-sm tracking-wide truncate"
                  >Dashboard 🚀</span
                >
              </a>
            </li>
            <li v-if="isAdmin">
              <a
                @click="Admin"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
                    ></path>
                  </svg>
                </span>
                <span
                  @click="Dashboard"
                  class="ml-2 text-sm tracking-wide truncate"
                >
                  Admin Dashboard 🚀
                </span>
              </a>
            </li>
            <li>
              <a
                @click="Clock"
                href="#"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-6 h-6"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71V3.5z"
                    />
                    <path
                      d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0z"
                    />
                  </svg>
                </span>
                <span @click="Clock" class="ml-2 text-sm tracking-wide truncate"
                  >My Clock</span
                >
              </a>
            </li>
            <li>
              <a
                @click="workingTimes"
                style="cursor: pointer"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"
                    ></path>
                  </svg>
                </span>
                <span class="ml-2 text-sm tracking-wide truncate"
                  >My Workingtimes</span
                >
              </a>
            </li>
            <li class="px-5">
              <div class="flex flex-row items-center h-8">
                <div class="text-sm font-light tracking-wide text-gray-500">
                  Settings
                </div>
              </div>
            </li>
            <li>
              <a
                @click="Profile"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
                    ></path>
                  </svg>
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">Profile</span>
              </a>
            </li>
            <li>
              <a
                @click="Teams"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
                    ></path>
                  </svg>
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">Teams</span>
              </a>
            </li>
            <li>
              <a
                @click="Logout"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"
                    ></path>
                  </svg>
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">Logout</span>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      loading: false,
    };
  },
  methods: {
    Logout() {
      this.isUserConnected = false;
      localStorage.removeItem("userId");
      localStorage.removeItem("role");
      const $toast = useToast();
      $toast.success("You are logged out!");
      localStorage.removeItem("userEmail");
      localStorage.removeItem("userUsername");
      this.isUserConnected = false;
      VueCookies.remove("token");
      router.replace("/");
      this.$emit("userConnected");
    },
    Dashboard() {
      router.push("/dashboard/" + localStorage.getItem("userId"));
    },
    Clock() {
      router.push("/clock/" + localStorage.getItem("userId"));
    },
    Profile() {
      router.push("/Profile/" + localStorage.getItem("userId"));
    },
    workingTimes() {
      router.push("/working-times/" + localStorage.getItem("userId"));
    },
    Admin() {
      router.push("/admin");
    },
    Teams() {
      router.push("/Teams/" + localStorage.getItem("userId"));
    },
  },
};
</script>

<style scoped></style>
