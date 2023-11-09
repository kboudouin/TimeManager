<template>
  <div class="container mx-auto py-4">
    <h1 class="text-3xl font-semibold mb-4">Gestion des équipes</h1>

    <!-- Section "Mes équipes" -->
    <section class="mb-8">
      <h2 class="text-xl font-semibold mb-4">Mes équipes</h2>
      <div class="carousel w-full">
        <div
          v-for="(group, index) in groupedTeams"
          :key="index"
          :id="'slide' + (index + 1)"
          class="carousel-item relative w-full"
        >
          <ul class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <li
              v-for="team in group"
              :key="team.id"
              class="bg-white p-4 rounded-lg shadow"
            >
              <h3 class="text-lg font-semibold">{{ team.leader }}</h3>
              <p class="text-gray-500">{{ team.description }}</p>
              <button
                @click="editTeam(team.id)"
                class="mt-4 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600"
              >
                Modifier
              </button>
            </li>
          </ul>
          <div
            class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2"
          >
            <a
              :href="
                '#slide' + (index === 0 ? groupedTeams.length - 1 : index - 1)
              "
              class="btn btn-circle"
              >❮</a
            >
            <a
              :href="
                '#slide' + (index === groupedTeams.length - 1 ? 0 : index + 1)
              "
              class="btn btn-circle"
              >❯</a
            >
          </div>
        </div>
      </div>
    </section>

    <!-- Section "Toutes les équipes" -->

    <section class="mb-8">
      <h2 class="text-xl font-semibold mb-4">Toutes les équipes</h2>
      <div class="carousel w-full">
        <div
          v-for="(group, index) in groupedTeams"
          :key="index"
          :id="'slide' + (index + 1)"
          class="carousel-item relative w-full"
        >
          <ul class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <li
              v-for="team in group"
              :key="team.id"
              class="bg-white p-4 rounded-lg shadow"
            >
              <h3 class="text-lg font-semibold">{{ team.name }}</h3>
              <p class="text-gray-500">{{ team.description }}</p>
              <button
                @click="editTeam(team.id)"
                class="mt-4 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600"
              >
                Modifier
              </button>
            </li>
          </ul>
          <div
            class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2"
          >
            <a
              :href="
                '#slide' + (index === 0 ? groupedTeams.length - 1 : index - 1)
              "
              class="btn btn-circle"
              >❮</a
            >
            <a
              :href="
                '#slide' + (index === groupedTeams.length - 1 ? 0 : index + 1)
              "
              class="btn btn-circle"
              >❯</a
            >
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
import axios from "axios";
import VueCookies from "vue-cookies";
import { useToast } from "vue-toast-notification";

export default {
  data() {
    return {
      username: "",
      BOUTONVISIBILITY: false,
      leaderIDselected: null,
      userUsername: null,
      id: null,
      EMAIL: null,
      selectedMembers: [],
      LIST: [],
    };
  },
  created() {
    // Récupérez la valeur depuis le localStorage
    this.userUsername = localStorage.getItem("userUsername");
    this.id = localStorage.getItem("userId");
    this.EMAIL = localStorage.getItem("userEmail");
  },
  methods: {
    addToMyList(item) {
      this.myList.push(item);
    },

    test() {
      console.log("test reussi");
    },

    addSelectedMember(memberId) {
      const member = this.availableMembers.find((m) => m.id === memberId);
      if (member) {
        this.selectedMembers.push(member.username);
        nameusername = member.username;
        console.log("le membre selectionner est" + member.username);
      }
    },

    BOUTON() {
      if (this.BOUTONVISIBILITY) {
        this.BOUTONVISIBILITY = false;
      } else if (!this.BOUTONVISIBILITY) {
        this.BOUTONVISIBILITY = true;
      }
    },
  },

  setup() {
    const teams = [
      // Ajoutez d'autres équipes ici
    ];

    const newTeam = ref({
      name: "",
      description: "",
      members: [],
    });

    const availableMembers = ref([]);
    const groupedTeams = ref([]);
    const selectedMembers = ref([]);

    const addSelectedMember = (memberId) => {
      const member = this.availableMembers.find((m) => m.id === memberId);
      if (member) {
        this.selectedMembers.push(member.username);
        nameusername = member.username;
        console.log("le membre sélectionné est " + member.username);

        // Définir la variable memberName
        memberName = member.name;
      }
    };

    const removeMember = (memberId) => {
      const index = newTeam.members.indexOf(memberId);
      if (index !== -1) {
        newTeam.members.splice(index, 1);
      }
    };

    const creatingTeam = ref(false);

    const showCreateTeamForm = () => {
      creatingTeam.value = true;
      newTeam.value = { name: "", description: "", members: [] };
    };

    const toggleCreateTeamForm = () => {
      creatingTeam.value = !creatingTeam.value;
    };

    const addTeam = async () => {
      try {
        const response = await axios.post(
          "https://epitechproject.com/api/teams",
          newTeam.value
        );

        if (response.status === 201) {
          useToast().success("Équipe ajoutée avec succès.");
          creatingTeam.value = false;

          // Ajoutez l'équipe nouvellement créée à la liste des équipes
          teams.push({
            leaderId: this.id,
            leader: this.userUsername,
            members: newTeam.value.members,
          });

          // Mise à jour de groupedTeams
          console.log("reussi");
          groupedTeams.value = groupTeams(teams);
        } else {
          useToast().error("Erreur lors de l'ajout de l'équipe.");
        }
      } catch (error) {
        console.error("Erreur lors de l'ajout de l'équipe", error);
        useToast().error("Erreur lors de l'ajout de l'équipe.");
      }
    };

    const API = () => {
      const token = localStorage.getItem("token");
      console.log("Récupération de la liste des membres en cours...");
      axios
        .get("https://epitechproject.com/api/users", {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        })
        .then((response) => {
          console.log("Membres trouvés");
          console.log(response.data);

          if (response.data.users) {
            availableMembers.value = response.data.users;
          }
        })
        .catch((error) => {
          console.error("Requête API échouée :", error);
        });
    };

    const BOUTONVISIBILITY = ref(false);

    const toggleCreateForm = () => {
      BOUTONVISIBILITY.value = true;
    };

    onMounted(() => {
      API();
    });

    return {
      BOUTONVISIBILITY,
      teams,
      creatingTeam,
      newTeam,
      groupedTeams,
      showCreateTeamForm,
      addTeam,
      availableMembers,
      selectedMembers,
      addSelectedMember,
      toggleCreateForm,
      toggleCreateTeamForm,
      removeMember,
    };
  },
};
</script>
