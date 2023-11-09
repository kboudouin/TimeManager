<script setup>
import { ref } from "vue";
import axios from "axios";
import { useToast } from "vue-toast-notification";
import VueCookies from "vue-cookies";
import { useRoute } from "vue-router";
import router from "../router";

const showDelModal = ref(false);

const deleteToggle = async () => {
  showDelModal.value = !showDelModal.value;
};
</script>

<template>
  <h1 class="text-4xl mt-2 font-bold">Hello {{ userUsername }} !</h1>
  <br />

  <div class="heromin-h-screen">
    <div class="hero-content flex-col lg:flex-row-reverse">
      <div class="stats stats-vertical bg-base-200 w-full md:w-96 shadow">
        <div class="stat">
          <div class="stat-title mb-4">Username</div>
          <!-- <div class="stat">{{ userUsername }}</div> -->

          <input
            type="text"
            placeholder="New username"
            class="input input-bordered"
            required
            ref="usernameInput"
            v-model="userUsername"
          />
          <button @click="updateusername" class="btn btn-active">
            UPDATE USERNAME
          </button>
        </div>

        <div class="stat">
          <div class="stat-title">Email</div>
          <!-- <div class="stat">{{ EMAIL }}</div> -->
          <br />
          <input
            type="text"
            placeholder="New email"
            class="input input-bordered"
            required
            ref="emailInput"
            v-model="EMAIL"
          />
          <button @click="updatemail" class="btn btn-active">
            UPDATE EMAIL
          </button>
        </div>
        <div class="stat mt-4">
          <h1 class="text-xl">Delete your account ?</h1>
          <div class="form-control mt-6">
            <button @click="deleteToggle" class="btn btn-error">DELETE</button>
          </div>
          <div
            v-if="showDelModal"
            tabindex="-1"
            class="fixed top-0 left-0 flex justify-center w-full h-full z-50 p-4 overflow-x-hidden overflow-y-auto mt-12"
          >
            <div class="relative w-full max-w-md max-h-full">
              <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                <button
                  type="button"
                  class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ml-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
                  data-modal-hide="popup-modal"
                >
                  <svg
                    class="w-3 h-3"
                    aria-hidden="true"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 14 14"
                  >
                    <path
                      stroke="currentColor"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"
                    />
                  </svg>
                  <span class="sr-only">Close modal</span>
                </button>
                <div class="p-6 text-center">
                  <svg
                    class="mx-auto mb-4 text-gray-400 w-12 h-12 dark:text-gray-200"
                    aria-hidden="true"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 20 20"
                  >
                    <path
                      stroke="currentColor"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M10 11V6m0 8h.01M19 10a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
                    />
                  </svg>
                  <h3
                    class="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400"
                  >
                    Are you sure you want to delete your account ?
                  </h3>
                  <button
                    @click="Deleteacc"
                    type="button"
                    class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 dark:focus:ring-red-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2"
                  >
                    Yes, I'm sure
                  </button>
                  <button
                    @click="deleteToggle"
                    type="button"
                    class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10 dark:bg-gray-700 dark:text-gray-300 dark:border-gray-500 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-600"
                  >
                    No, cancel
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      SignInDiv: true,
      showCreateAccount: false,
      username: "",
      email: "",
      isUserConnected: !!localStorage.getItem("userId"),
      userUsername: null,
      id: null,
      EMAIL: null,
      newusername: null,
      newmail: null,
      newid: null,
      token: localStorage.getItem("token"),
    };
  },
  created() {
    // Récupérez la valeur depuis le localStorage
    this.userUsername = localStorage.getItem("userUsername");
    this.id = localStorage.getItem("userId");
    this.EMAIL = localStorage.getItem("userEmail");
  },
  methods: {
    // Mail+ID+ s (GET)
    API() {
      console.log("list of users in process...");
      const email1 = this.email;
      const username1 = this.username;
      axios
        .get(`https://epitechproject.com/api/users`, {
          params: {
            email: email1,
            username: username1,
          },
          headers: {
            Authorization: `Bearer ${this.token}`,
          },
        })
        .then((response) => {
          console.log("Users found");
          console.log(response.data);
          if (response.data.users) {
            const user = response.data.users[0];

            localStorage.setItem("userEmail", user.email);
            localStorage.setItem("userUsername", user.username);
            localStorage.setItem("userId", user.id);
            this.isUserConnected = true;
          }
        })
        .catch((error) => {
          console.error("API request failed:", error);
        });
    },

    Deleteacc() {
      axios
        .delete(
          `https://epitechproject.com/api/users/` +
            localStorage.getItem("userId"),
          {
            headers: {
              Authorization: `Bearer ${this.token}`,
            },
          }
        )
        .then((response) => {
          console.log("API response received: USER BEEN DELETED");
          console.log(response.data);
          localStorage.removeItem("userEmail");
          localStorage.removeItem("userUsername");
          localStorage.removeItem("userId");
          this.isUserConnected = false;
          window.location.replace("/");
          // this.$router.replace("/");
        })
        .catch((error) => {
          console.error("API request failed:", error);
          const $toast = useToast();
          $toast.error("An error occured, please try again later");
        });
    },

    updatemail() {
      if (this.$refs.emailInput.value == "") {
        const $toast = useToast();
        $toast.error("Email can't be empty!");
        return;
      }
      this.newmail = this.$refs.emailInput.value;
      const userId = localStorage.getItem("userId");
      axios
        .put(
          "https://epitechproject.com/api/users/" +
            userId +
            "?email=" +
            this.newmail,
          {},
          {
            headers: {
              Authorization: `Bearer ${this.token}`,
            },
          }
        )
        .then((response) => {
          console.log("API response received: MAIL BEEN UPDATED");
          console.log(response.data);
          const $toast = useToast();
          $toast.success(
            response.data.info + "logout and login to see changes"
          );
        });
    },

    updateusername() {
      if (this.$refs.usernameInput.value == "") {
        const $toast = useToast();
        $toast.error("Username can't be empty!");
        return;
      }
      this.newusername = this.$refs.usernameInput.value;
      console.log(
        "UPDATE USERNAME FROM " +
          localStorage.getItem("userId") +
          " TO " +
          this.newusername
      );
      const userId = localStorage.getItem("userId");
      axios
        .put(
          "https://epitechproject.com/api/users/" +
            userId +
            "?username=" +
            this.newusername,
          {},
          {
            headers: {
              Authorization: `Bearer ${this.token}`,
            },
          }
        )
        .then((response) => {
          console.log("API response received: USERNAME BEEN UPDATED");
          console.log(response.data);
          const $toast = useToast();
          $toast.success(
            response.data.info + " logout and login to see changes"
          );
        });
    },
  },
};
</script>

<style scoped></style>
