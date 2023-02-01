defmodule GradingServer.KeyTest do
  use GradingServer.DataCase

  alias GradingServer.Key

  describe "answers" do
    alias GradingServer.Key.Answer

    import GradingServer.KeyFixtures

    @invalid_attrs %{answer: nil, help_text: nil, question_id: nil}

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Key.list_answers() == [answer]
    end

    test "get_answer/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Key.get_answer(answer.question_id) == answer
    end

    test "get_answer_by!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Key.get_answer_by!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates an answer" do
      valid_attrs = %{answer: "some answer", help_text: "some help_text", question_id: 42}

      assert {:ok, %Answer{} = answer} = Key.create_answer(valid_attrs)
      assert answer.answer == "some answer"
      assert answer.help_text == "some help_text"
      assert answer.question_id == 42
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Key.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      update_attrs = %{answer: "some updated answer", help_text: "some updated help_text", question_id: 43}

      assert {:ok, %Answer{} = answer} = Key.update_answer(answer, update_attrs)
      assert answer.answer == "some updated answer"
      assert answer.help_text == "some updated help_text"
      assert answer.question_id == 43
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Key.update_answer(answer, @invalid_attrs)
      assert answer == Key.get_answer_by!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Key.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Key.get_answer_by!(answer.id) end
    end

    test "change_answer/1 returns an answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Key.change_answer(answer)
    end
  end
end
